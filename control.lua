local function ensure_global()
  global = global or {}
  global.schema = global.schema or {}
  global.schema.version = global.schema.version or 1
  global.schema.registered = global.schema.registered or false
  global.schema.register_attempts = global.schema.register_attempts or 0
end

local function try_register()
  ensure_global()
  if global.schema.registered then return true end

  -- Wait until Cargo Ships interface is available
  if not (remote and remote.interfaces and remote.interfaces["cargo-ships"] and remote.interfaces["cargo-ships"].add_ship) then
    return false
  end

  global.schema.register_attempts = (global.schema.register_attempts or 0) + 1

  local ok = pcall(function()
    remote.call("cargo-ships", "add_ship", {
      name = "container_cargo_ship",
      engine = "container_cargo_ship_engine",
      engine_scale = 1,
      engine_at_front = false,
    })
  end)

  if ok then
    global.schema.registered = true
    return true
  end
  return false
end

script.on_event(defines.events.on_player_created, function(event)
    local player = game.players[event.player_index]
    local player_chara = player.character or player.cutscene_character
    if not player_chara then
        return
    end

    if settings.startup["mdpy-robo-start"].value == true then
        -- Basic Armor
        player_chara.insert{name="light-armor", count = 1}

        local grid = player_chara.get_inventory(defines.inventory.character_armor)[1].grid
        grid.put({name = "portable-gasoline-generator"})
        grid.put({name = "personal-roboport-equipment"})

        -- Bots and Fuel
        player_chara.insert{name="py-construction-robot-mk01", count = 10}
        player_chara.insert{name="tar-canister", count = 80}

        -- Barrel machine because I'm just too kind.
        player_chara.insert{name="barrel-machine-mk01", count = 1}

        -- Make Ghosts live from the start
        --local force = player.force
        --force.ghost_time_to_live = 4294967295
    end

    if settings.startup["mdpy-military-start"].value == true then
        player_chara.insert{name="submachine-gun", count = 1}
        player_chara.insert{name="firearm-magazine", count = 300}
        player_chara.insert{name="gun-turret", count = 5}
        player_chara.insert{name="stone-wall", count = 200}
    end

    if script.active_mods.PyBlock and settings.startup["mdpy-pyblock-start"].value == true then
        player_chara.insert{name="basic-ddc", count = 1}
        player_chara.insert{name="offshore-pump", count = 1}
        player_chara.insert{name="boiler", count = 1}
        player_chara.insert{name="steam-engine", count = 1}
        player_chara.insert{name="soil-extractormk01", count = 1}
        player_chara.insert{name="spore-collector-mk01", count = 1}
        player_chara.insert{name="solid-separator", count = 1}
        player_chara.insert{name="burner-washer", count = 1}
    end
end)

script.on_configuration_changed(function()
    if script.active_mods.pyhardmode then
        for _, force in pairs(game.forces) do
            force.manual_crafting_speed_modifier = 2
        end
    end

    if script.active_mods['container-cargo-ship'] then
        ensure_global()
        -- Re-register in case Cargo Ships was updated/reset
        global.schema.registered = false
        try_register()
    end
end)


script.on_init(function()
  if script.active_mods['container-cargo-ship'] then
      ensure_global()
      try_register()
  end
end)

-- Retry a few times in case load order / remote interface isn't ready yet
script.on_event(defines.events.on_tick, function(event)
   if script.active_mods['container-cargo-ship'] then
      ensure_global()
      if global.schema.registered then
        script.on_event(defines.events.on_tick, nil)
        return
      end

      -- Try once per second (60 ticks). Stop after 10 tries to avoid overhead.
      if (event.tick % 60) ~= 0 then return end
      if (global.schema.register_attempts or 0) >= 10 then
        script.on_event(defines.events.on_tick, nil)
        return
      end

      if try_register() then
        script.on_event(defines.events.on_tick, nil)
      end
   end
end)