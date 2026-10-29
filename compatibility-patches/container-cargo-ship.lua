CARGO_SHIP_GP = "__cargo-ships-graphics__/graphics/"
GRAPHICSPATH = "__container-cargo-ship__/graphics/"
local function unlock(recipe)
  return {
    type = "unlock-recipe",
    recipe = recipe
  }
end
data:extend({
    {
        type = "technology",
        name = "container_cargo_ship",
        icon = GRAPHICSPATH .. "icons/container_cargo_ship.png",
        icon_size = 256,
        effects = {
            unlock("container_cargo_ship"),
        },
        prerequisites = { "railway-mk02" },
        unit = {
            count = 1400,
            ingredients = {
                { "automation-science-pack", 6 },
                { "py-science-pack-1",       3 },
                { "logistic-science-pack",   2 },
                { "py-science-pack-2",       1 },
            },
            time = 90
        },
        order = "c-g-a",
    }
})

--------------------------------------------------------------------------
------------------------ CONTAINER CARGO SHIP ENGINE ---------------------
--------------------------------------------------------------------------
local function get_icons(prototype, default_icon_size)
  return prototype.icons or {{icon=prototype.icon, icon_size=prototype.icon_size or default_icon_size or 64}}
end
local icon_inputs = {tint={0.4,0.4,1}, scale=0.6, shift={7,-7}}

local speed_modifier = settings.startup["speed_modifier"].value
local fuel_modifier = settings.startup["fuel_modifier"].value
local ship_max_speed = 0.3 * speed_modifier

local cargo_ship_icons = {{icon=CARGO_SHIP_GP .. "icons/cargoship_icon.png", icon_size = 64}}

local container_cargo_ship_engine_power = 4000 + (speed_modifier-1)*2400

local container_cargo_ship_engine = table.deepcopy(data.raw["locomotive"]["locomotive"])
container_cargo_ship_engine.name = "container_cargo_ship_engine"
container_cargo_ship_engine.minable = {mining_time = 1, result = nil}
container_cargo_ship_engine.flags =  {"placeable-neutral", "player-creation", "placeable-off-grid"}
container_cargo_ship_engine.hidden_in_factoriopedia = true
container_cargo_ship_engine.allow_copy_paste = true
container_cargo_ship_engine.icons = util.combine_icons(cargo_ship_icons, get_icons(data.raw["item"]["engine-unit"]),
                                  icon_inputs)
container_cargo_ship_engine.icon = nil
container_cargo_ship_engine.weight = 100000
container_cargo_ship_engine.max_speed = ship_max_speed
container_cargo_ship_engine.max_power = container_cargo_ship_engine_power.."kW"
container_cargo_ship_engine.air_resistance = 0.40
container_cargo_ship_engine.collision_box = {{-1.1, -1.2}, {1.1, 1.2}}
container_cargo_ship_engine.selection_box = {{-1.3, -1.2}, {1.3, 1.2}}
container_cargo_ship_engine.selection_priority = 51
container_cargo_ship_engine.connection_distance = 3
container_cargo_ship_engine.joint_distance = 1.7
container_cargo_ship_engine.energy_source = {
  type = "burner",
  fuel_categories = {"chemical", "biomass", "nuke", "nuclear"},
  effectivity = 1,
  fuel_inventory_size = 5 * fuel_modifier,
  smoke = {
    {
      name = "tank-smoke",
      deviation = {0.3, 1.5},
      frequency = 200,
      position = {0, 1},
      starting_frame = 0,
      starting_frame_deviation = 60,
      height = 3,
      height_deviation = 0.5,
      starting_vertical_speed = 0.0,
      starting_vertical_speed_deviation = 0.1,
    },
    {
      name = "wave",
      deviation = {0.3, 0.3},
      frequency = 30,
      position = {-0.8, 1},
      starting_frame = 0,
      starting_frame_deviation = 60,
      height = 0,
      height_deviation = 0.2,
      starting_vertical_speed = 0.0,
      starting_vertical_speed_deviation = 0,
    },
    {
      name = "wave",
      deviation = {0.3, 0.3},
      frequency = 30,
      position = {0.8, 1},
      starting_frame = 0,
      starting_frame_deviation = 60,
      height = 0,
      height_deviation = 0.2,
      starting_vertical_speed = 0.0,
      starting_vertical_speed_deviation = 0,
    },
    {
      name = "wave_circle",
      deviation = {0.8, 0.8},
      frequency = 15,
      position = {0, 1},
      starting_frame = 0,
      starting_frame_deviation = 60,
      height = 0,
      height_deviation = 0.2,
      starting_vertical_speed = 0.0,
      starting_vertical_speed_deviation = 0,
    },

  }
}
container_cargo_ship_engine.pictures = nil
container_cargo_ship_engine.minimap_representation = nil
container_cargo_ship_engine.selected_minimap_representation = nil
container_cargo_ship_engine.water_reflection = nil
container_cargo_ship_engine.wheels = nil
container_cargo_ship_engine.working_sound = tank_sounds
container_cargo_ship_engine.front_light = nil
container_cargo_ship_engine.front_light_pictures = nil
container_cargo_ship_engine.back_light = nil
container_cargo_ship_engine.stand_by_light = nil
container_cargo_ship_engine.stop_trigger = nil
container_cargo_ship_engine.drive_over_tie_trigger = nil
container_cargo_ship_engine.factoriopedia_simulation = nil
container_cargo_ship_engine.corpse = nil

data:extend{container_cargo_ship_engine}



TECHNOLOGY("cargo_ships").effects = {unlock("cargo_ship")}

RECIPE("container_cargo_ship")
        :clear_ingredients()
        :add_ingredient({type = "item", name = "nexelit-plate", amount = 40})
        :add_ingredient({type = "item", name = "self-assembly-monolayer", amount = 10})
        :add_ingredient({type = "item", name = "brake-mk02", amount = 10})
        :add_ingredient({type = "item", name = "gearbox-mk02", amount = 2})
        :add_ingredient({type = "item", name = "shaft-mk02", amount = 10})
        :add_ingredient({type = "item", name = "steam-turbine-mk01", amount = 2})
        :add_ingredient({type = "item", name = "electronic-circuit", amount = 40})
        :add_ingredient({type = "item", name = "rubber", amount = 80})
        :add_ingredient({type = "item", name = "small-parts-01", amount = 200})
        :add_ingredient({type = "item", name = "small-parts-02", amount = 100})
        :add_ingredient({type = "item", name = "plastic-bar", amount = 300})
        :add_ingredient({type = "item", name = "steel-plate", amount = 300})
        :add_ingredient({type = "item", name = "duralumin", amount = 100})
        :add_ingredient({type = "item", name = "glass", amount = 300})
        :add_ingredient({type = "item", name = "niobium-plate", amount = 150})
        :add_ingredient({type = "item", name = "nickel-plate", amount = 80})
        :add_ingredient({type = "item", name = "aluminium-plate", amount = 40})
