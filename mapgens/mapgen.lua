local blocklist = {
    ["enemy-base"] = true,
    ["trees"] = true,
}

local rocks = {
    ["iron-rock"] = true,
    ["copper-rock"] = true,
    ["uranium-rock"] = true,
    ["zinc-rock"] = true,
    ["aluminium-rock"] = true,
    ["chromium-rock"] = true,
    ["coal-rock"] = true,
    ["lead-rock"] = true,
    ["nexelit-rock"] = true,
    ["nickel-rock"] = true,
    ["phosphate-rock-02"] = true,
    ["quartz-rock"] = true,
    ["salt-rock"] = true,
    ["tin-rock"] = true,
    ["titanium-rock"] = true,
    ["volcanic-pipe"] = true,
    ["regolites"] = true,
    ["rare-earth-bolide"] = true,
    ["phosphate-rock"] = true,
    ["sulfur-patch"] = true,
    ["geothermal-crack"] = true,
    -- ['bitumen-seep'] = true
}

local vanilla_non_rocks = {
    ["iron-ore"] = true,
    ["copper-ore"] = true,
    ["stone"] = true,
    ["uranium-ore"] = true,
}

local mapgens = data.raw["map-gen-presets"]["default"]
mapgens["md-marathon-islands"] = {
    order = "i",
    basic_settings = {
        autoplace_controls = {
            ["enemy-base"] = {
                frequency = .33,
                size = .5,
            },
            water = {frequency = 0.33, size = 3.0},
            trees = {frequency = 0.5, size = 2.0},
            rocks = {frequency = 0.5, size = 2.0},
        },
        cliff_settings = {
            cliff_elevation_interval = 40 / 0.5,
            richness = 3
        },
        starting_area = mods["rso-mod"] and "normal" or 4
    },
    advanced_settings = {
        enemy_evolution = {
            time_factor = 0.0,
            destroy_factor = 0.001,
            pollution_factor = 0.0
        },
        enemy_expansion = {
            enabled = true,
            max_expansion_distance = 2,            -- Creep only
            min_expansion_cooldown = 60 * 60 * 60, -- 60 min
            max_expansion_cooldown = 60 * 60 * 180 -- 180 min
        },
        difficulty_settings = {
            technology_price_multiplier = 48.0
        }
    }
}

local non_rock_values = {
    ["md-marathon-islands"] = {
        frequency = 0.17,
        richness = 6.0,
        size = 0.75
    },
}

-- Make vanilla resources more plentiful
local vanilla_non_rock_values = {
    ["md-marathon-islands"] = {
        frequency = 0.50,
        richness = 12.0,
        size = 1.50
    },
}

local rock_values = {
    ["md-marathon-islands"] = {
        frequency = 0.33,
        richness = 5
    },
}

for name in pairs(data.raw["autoplace-control"]) do
    if blocklist[name] then goto continue end
    local is_rock = rocks[name]
    for preset_name, preset_data in pairs(mapgens) do
        local control = preset_data["basic_settings"] and preset_data["basic_settings"]["autoplace_controls"]
        -- If someone has already modified it, I see no reason to change it
        if control and not control[name] then
            if vanilla_non_rocks[name] then
                control[name] = vanilla_non_rock_values[preset_name]
            else
                control[name] = is_rock and rock_values[preset_name] or non_rock_values[preset_name]
            end
        end
    end
    ::continue::
end