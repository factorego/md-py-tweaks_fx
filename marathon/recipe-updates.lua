
local multi = settings.startup["mdpy-marathon-multi"].value
local ultra_multi = settings.startup["mdpy-ultra-marathon-multi"].value

local user_block_string = settings.startup["mdpy-marathon-blocklist"].value or ""
local user_blocklist = {}
if user_block_string ~= "" then
    for word in string.gmatch(user_block_string, '([^,]+)') do
        user_blocklist[#user_blocklist+1] = word
    end
end

local user_ing_block_string = settings.startup["mdpy-marathon-ing-blocklist"].value or ""
local user_ing_blocklist = {}
if user_ing_block_string ~= "" then
    for word in string.gmatch(user_ing_block_string, '([^,]+)') do
        user_ing_blocklist[#user_ing_blocklist+1] = word
    end
end

-- Recipes that don't make sense to multiply
local recipe_blocklist = {
    'nuclear-reactor-mox-mk01',
    'nuclear-reactor-mox-mk01-uncraft',
    'nuclear-reactor-mox-mk02',
    'nuclear-reactor-mox-mk02-uncraft',
    'nuclear-reactor-mox-mk03',
    'nuclear-reactor-mox-mk03-uncraft',
    'nuclear-reactor-mox-mk04',
    'nuclear-reactor-mox-mk04-uncraft',
    'nexelit-battery-recharge',
    'quantum-battery-recharge',
    'personal-fusion-cell-refuel'
}

-- Ingredients that will be skipped by all recipes.
local ingredient_multiplier_blocklist = {
    'used-nexelit-battery',
    'used-quantum-battery',
    'steam',
    'yag-laser-module',
    'vacuum',
    'water',
    'light-armor',
    'heavy-armor',
    'modular-armor',
    'power-armor',
    'power-armor-mk2',
}

local marathon_mode_subgroups = {
    'storage',
    'py-storage-tanks',
    'belt',
    'loader',
    'inserter',
    'inserter-cranes', -- Inserter Cranes for Py
    'water_transport', -- Cargo Ships
    'py-pipes',
    'energy-pipe-distribution',
    'py-electric',
    'train-transport',
    'logistic-network',
    'py-stations',
    'py-robots',
    'circuit-network',
    'py-trains',
    'tool',
    'energy',
    'extraction-machine',
    'smelting-machine',
    'production-machine',
    'module',
    'py-void',
    'gun',
    'armor',
    'equipment',
    'military-equipment',
    'transport',
    'defensive-structure',
    'py-battery-equipment',
    'py-generator-equipment',
    'py-fusion-reactors',
    'py-alternativeenergy-thermosolar',
    'py-alternativeenergy-special-buildings',
    'py-alienlife-biofluid-network',
    'py-hightech-buildings',
    'py-rawores-mines',
    'spacex-stage-1',
    'spacex-stage-2',
    'spacex-stage-3',
    'spacex-stage-4',
    'landscaping-earthworks',
    'py-tiles',
    'py-walls',
    'transport',
    'utility-equipment',
    -- Advanced Fliud Handling
    'pipes-to-ground',
    'pipes-to-ground-t2',
    'pipes-to-ground-t3',
    'underground-pipes',
    'underground-pipes-t2',
    'underground-pipes-t3',

}

local marathon_mode_names = {
    'boat', -- Cargo Ships
    'cargo_ship', -- Cargo Ships
    'oil_tanker', -- Cargo Ships
    'container_cargo_ship', -- Container Cargo Ships
    'niobium-mine',
    'co2-absorber',
    'cooling-tower-mk01',
    'cooling-tower-mk02',
    'tailings-pond',
    'empty-barrel',
    'electronic-circuit',
    'electronic-circuit-2',
    'advanced-circuit',
    'processing-unit',
    'intelligent-unit',
    'antimatter',
    'fast-inserter-2',
    'filter-inserter-2',
    'long-handed-inserter-2',
    'stack-filter-inserter-2',
    'stack-inserter-2',
    'express-transport-belt-2',
    'fast-transport-belt-2',
    'transport-belt-2',
    'casting-pipe',
    'hotair-casting-pipe',
    'casting-pipe-ug',
    'hotair-casting-pipe-ug',
    'casting-niobium-pipe',
    'hotair-casting-niobium-pipe',
    'casting-niobium-pipe-underground',
    'hotair-casting-niobium-pipe-underground',
    'casting-ht-pipe',
    'hotair-casting-ht-pipe',
    'casting-ht-pipe-underground',
    'hotair-casting-ht-pipe-underground',
    'landfill',
    'cliff-explosives',
    'concrete',
    'concrete-02',
    'refined-concrete',
    'rail', -- Apparently not captured by the rail-transport group
    'rail-2',
    'rail-ramp',
    'artillery-wagon',
    'mk02-locomotive',
    'ht-locomotive',
    'mk04-locomotive',
    -- pY Alien Life Special Creatres
    'caravan',
    'fluidavan',
    'flyavan',
    'nukavan',
    'ocula',
    'digosaurus',
    'thikat',
    'work-o-dile',
    'crawdad',
    'dingrido',
    'spidertron',
    'phadaisus',
    -- pY Alien Life Misc
    'vat-brain',
    -- pY Alien Life Plant Samples
    'ralesia-sample',
    'rennea-sample',
    'yotoi-sample',
    'tuuphra-sample',
    'grod-sample',
    'cridren-sample',
    'kicalk-sample',
    'cadaveric-arum-sample',
    'guar-sample',
    'bhoddos-sample',
    'fawogae-sample',
    'navens-sample',
    'yaedols-sample',
    'moondrop-sample',
    -- pY Alien Life Initial Creatures
    'ulric',
    'auog',
    'mukmoux',
    'vrauks',
    'arthurian',
    'dhilmos',
    'scrondrix',
    'phadai',
    'dingrits',
    'kmauts',
    'vonix',
    'phagnot',
    'xeno',
    'antelope',
    'zipir1',
    'trits',
    'xyhiphoe',
    'simik',
    'korlex',
    'cottongut',
    'arqad',
    'numal',
    'zungror'
}

local marathon_recipe_subgroup_contains = {
    '%-buildings%-',
    '%-buildings',
    'py%-containers%-'
}

local tech_marathon_mode_subgroups = {
    'space-related',
    'science-pack',
    'py-hightech-quantum'
}

local ultra_marathon_mode_subgroups = {
    'ammo',
    'capsule',
    'py-alternativeenergy-items',
    'py-alternativeenergy-intermetallics-1',
    'py-alternativeenergy-intermetallics-2',
    'py-alternativeenergy-intermetallics-3',
    'py-alternativeenergy-parts',
    'py-alternativeenergy-engine-units',
    'py-alienlife-genetics',
    'py-alienlife-samples',
    'py-alienlife-codex',
    'py-alienlife-codex-mk02',
    'py-alienlife-codex-mk03',
    'py-alienlife-codex-mk04',
    'py-hightech-items',
    'py-hightech-kicalk',
    'py-hightech-tier-1',
    'py-hightech-tier-2',
    'py-hightech-tier-3',
    'py-hightech-tier-4',
    'py-hightech-earnshaw',
    'py-petroleum-handling-plastic-recipes',
    'py-rawores-casting'
}

local ultra_marathon_mode_names = {
    -- Py Coal Processing
    'copper-cable',
    'iron-stick',
    'iron-gear-wheel',
    'flying-robot-frame',
    'animal-sample-01',
    'biofilm',
    'biofilm-3',
    'biofilm-pyht',
    'cladded-core',
    'cladding',
    'copper-coating',
    'kevlar',
    'kevlar-2',
    'kevlar-coating',
    'nfbe-alloy',
    'optical-fiber',
    'ppd',
    'empty-gas-canister',
    'empty-jerry-can',
    'flask',
    'flask-2',
    'flask-3',
    'hotair-flask',
    'hotair-flask-2',
    'hotair-flask-3',
    'alien-sample01',
    'ground-sample01',
    'bio-sample01',
    'equipment-chassi',
    'lab-instrument',
    'lab-instrument-2',
    'treated-wood',
    'glass-core',
    'hotair-glass-core',
    'lens',
    'hotair-lens',

    -- Py Fusion Energy
    'super-alloy',
    'hotair-super-alloy',
    'methyl-acrylate',
    'methyl-acrylate-2',
    'coated-container',
    'blanket',
    'blanket-chassis',
    'coil-core',
    'control-unit',
    'divertor',
    'ferrite',
    'lead-container',
    'magnetic-core',
    'nuclear-sample',
    'reinforced-wall-shield',
    'sc-coil',
    'sc-unit',
    'sc-wire',
    'science-coating',
    'silver-foam',
    'wall-shield',

    -- Py Alien Life
    'cage',
    'empty-neuromorphic-chip',
    'empty-petri-dish',
    'hotair-empty-petri-dish',
    'metallic-glass',
    'petri-dish',
    'quartz-tube',
    'ticocr-alloy',
    'cottongut-science-red-seeds',
    'cottongut-science-blue-seeds',
    'cottongut-science-green-seeds',
    'cottongut-science-prod-seeds',
    'cottongut-science-py-seeds',
    'agar',
    'bio-container',
    'empty-milk-barrel',
    'cobalt-floride',
    'magnetic-beads',
    'nanofibrils',
    'nanofibrils-2',
    'neuroprocessor',
    'empty-planter-box',
    'planter-box',
    'perfect-samples',

    -- Py Petroleum Handling
    'empty-proto-tholins-vessel',
    'bolts',
    'belt',
    'small-parts-01',
    'small-parts-02',
    'small-parts-03',
    'engine-unit-2',

    -- Py Raw Ores
    'casting-bolts',
    'hotair-casting-bolts',
    'casting-small-parts',
    'hotair-casting-small-parts',
    'casting-equipment-chassis',
    'hotair-casting-equipment-chassis',

    -- Advanced Fluid Handling
    'swivel-joint',
    'small-pipe-coupler',
    'medium-pipe-coupler',
    'large-pipe-coupler',
    'underground-pipe-segment-t1',
    'underground-pipe-segment-t2',
    'underground-pipe-segment-t3'
}

local ultra_marathon_mode_name_blocklist = {
    -- Py Alternative Energy
    'lead-acetate', -- Used in antimony production
    'sodium-cyanate', -- Used in antimony production
    'yellow-dextrine', -- Used in antimony production
    'crucible', -- Used in some casting
    'cyanoacetate', -- Used in alloy production
    'oxalic-acid', -- Used in plutonium production
    'oxalic-acid-2', -- Used in plutonium production
    'titanium-oxide', -- Kinda Used in uranium production
    'sb-oxide-01', -- Touches some nuclear production
    'sb-oxide-02', -- Touches some nuclear production
    'sb-oxide-02a', -- Touches some nuclear production
    'sb-oxide-04', -- Touches some nuclear production
    'acetaldehyde-1', -- Touches some nuclear production
    'acetaldehyde-2', -- Touches some nuclear production
    'pyridine', -- Touches some nuclear production
    'sb-silicate', -- Used in plutonium production
    'ammonium-mixture', -- Used in nuclear

    -- Py High Tech
    'clay', -- Just uses steam.
    'crusher-ree', -- Base ore recipe
    'ree-concentrate1', -- Waste product
    'ree-concentrate2', -- Waste product
    'ree-concentrate3', -- Waste product
    're-precipitate-01', -- Used in Rare Earth
    're-precipitate-02', -- Used in Rare Earth
    'crystallographic-substrate', -- Used in proton donor recipe
    'lithium-chloride', -- Used in Niobium
    'proton-donor', -- Proton donor recipes
    'proton-receiver', -- Proton donor recipes
    'cerment', -- Used in proton donor recipes
    'crude-cerment', -- Used in proton donor recipes
    'fecr-alloy', -- Used in stainless steel
    'fecr-alloy-2', -- Used in stainless steel
    'dry-ralesia', -- Processing recipe
    'ralesia-powder', -- Processing recipe
    'casting-drill-heads', -- Mining material
    'hotair-casting-drill-heads', -- Mining material
}

local function get_thing(name)
    for key, _ in pairs(data.raw) do
        if key ~= "technology" and key ~= "recipe" then
            if data.raw[key][name] then return data.raw[key][name] end
        end
    end
    return ""
    -- error("THING not found " .. name)
end

-- Function to retrieve the subgroup of a given recipe.
local function get_recipe_subgroup(recipe)
    local subgroup = "nil"
    if recipe.subgroup then
        subgroup = recipe.subgroup
    elseif recipe.main_product and recipe.main_product ~= "" then
        subgroup = get_thing(recipe.main_product).subgroup or ""
    elseif recipe.result then
        subgroup = get_thing(recipe.result).subgroup or ""
    elseif recipe.normal and recipe.normal.result then
        subgroup = get_thing(recipe.normal.result).subgroup or ""
    elseif recipe.results and recipe.results[1] and recipe.results[1].name then
        local name = recipe.results[1].name or recipe.results[1][1]
        subgroup = get_thing(name).subgroup or ""
    elseif recipe.normal and recipe.normal.results then
        local name = recipe.normal.results[1].name or recipe.normal.results[1][1]
        subgroup = get_thing(name).subgroup or ""
    end

    return subgroup
end

-- Marathon mode aims to increase recipe costs for most end products such as buildings, belts, circuits, etc.
local function is_marathon_mode_eligible_for_subgroup(subgroup)
    for _, sg in pairs(marathon_mode_subgroups) do
        if subgroup == sg then return true end
    end
    for _, part in pairs(marathon_recipe_subgroup_contains) do
        if string.find(subgroup, part) then return true end
    end
    return false
end

local function is_marathon_mode_eligible_for_name(name)
    for _, nm in pairs(marathon_mode_names) do
        if name == nm then return true end
    end
    return false
end

local function is_tech_marathon_mode_eligible_for_subgroup(subgroup)
    for _, sg in pairs(tech_marathon_mode_subgroups) do
        if subgroup == sg then return true end
    end
    return false
end

local function is_ultra_marathon_mode_enabled_for_subgroup(subgroup)
    for _, sg in pairs(ultra_marathon_mode_subgroups) do
        if subgroup == sg then return true end
    end
    return false
end

local function is_ultra_marathon_mode_enabled_for_name(name)
    for _, nm in pairs(ultra_marathon_mode_names) do
        if name == nm then return true end
    end
    return false
end


-- Check if recipe name matches turd variants
local function should_apply_turd_marathon_multi(recipe)
    local name = recipe.name
    if string.find(name, "turd") then
        return true
    end
    return false
end

local function is_ultra_marathon_mode_disabled_for_name(name)
    for _, nm in pairs(ultra_marathon_mode_name_blocklist) do
        if name == nm then return true end
    end
    return false
end

local function should_apply_marathon_multi(recipe)
    local subgroup = get_recipe_subgroup(recipe)
    local name = recipe.name
    log(subgroup .. ":" .. name)

    for _, block in pairs(user_blocklist) do
        if name == block then return false end
    end

    for _, block in pairs(recipe_blocklist) do
        if name == block then return false end
    end

    if settings.startup["mdpy-marathon"].value == true then
        if is_marathon_mode_eligible_for_subgroup(subgroup) or is_marathon_mode_eligible_for_name(name) then
            return true
        end
    end

    if settings.startup["mdpy-tech-marathon"].value == true then
        if is_tech_marathon_mode_eligible_for_subgroup(subgroup) then
            return true
        end
    end
    -- All turd variant recipes from pyalienlife should also scale
    if should_apply_turd_marathon_multi(recipe) then return true end
    return false
end

local function should_apply_ultra_marathon_multi(recipe)
    local subgroup = get_recipe_subgroup(recipe)
    local name = recipe.name
    log("Big Test")
    log(subgroup .. ":" .. name)
    for _, block in pairs(user_blocklist) do
        if name == block then return false end
    end

    if settings.startup["mdpy-ultra-marathon"].value == true then
        if  is_ultra_marathon_mode_disabled_for_name(name) then
            return false
        end
        if is_ultra_marathon_mode_enabled_for_subgroup(subgroup) or is_ultra_marathon_mode_enabled_for_name(name) then
            return true
        end
    end
    -- All turd variant recipes from pyalienlife should also scale
    if should_apply_turd_marathon_multi(recipe) then return true end
    return false

end

local function should_multiply_ingredients(ing)
    local ing_name = ing.name or ing[1]
    local ing_subgroup = get_thing(ing_name).subgroup or "other"

    log(ing_subgroup .. ":" .. ing_name)

    -- Skip blocklisted items
    for _, block in pairs(ingredient_multiplier_blocklist) do
        if ing_name == block then return false end
    end

    for _, block in pairs(user_ing_blocklist) do
        if ing_name == block then return false end
    end

    -- Plus Mode allows ALL eligible ingredients to multiply
    if settings.startup["mdpy-marathon-plus"].value == true then
        return true
    end

    if is_marathon_mode_eligible_for_subgroup(ing_subgroup) then
        --log("Skipping ingredient for subgroup: " .. ing_subgroup .. " ing_name: " .. ing_name)
        return false
    end

    if is_marathon_mode_eligible_for_name(ing_name) then
        --log("Skipping ingredient for name: " .. ing_subgroup .. " ing_name: " .. ing_name)
        return false
    end

    return true
end

for _, rcp in pairs(data.raw.recipe) do
    -- Extract the ingredients from the recipe. Note: we go for the normal ingredients if possible to just keep
    -- things consistent. Most py recipes don't have expensive ingredients listed because you'd have to be crazy
    -- to want to make them cost even more than they already do... amirite?
    local ingredients = {}
    if rcp.ingredients then
        ingredients = rcp.ingredients
    elseif rcp.normal then
        ingredients = rcp.normal.ingredients
    elseif rcp.expensive then
        ingredients = rcp.expensive.ingredients
    end

    local recipe = RECIPE(rcp.name)

    if should_apply_marathon_multi(rcp) then
        recipe.localised_description = {"", "☆ Marathon Recipe ", tostring(multi), "x"}

        recipe:clear_ingredients()
        for _, ing in pairs(ingredients) do
            if should_multiply_ingredients(ing) then
                local ing_amt = ing.amount or ing[2]
                local final_amt = mdpy.cap_amount(math.floor((ing_amt * multi) + 0.5))
                if ing.amount then ing.amount = final_amt else ing[2] = final_amt end
            end
        end
    elseif should_apply_ultra_marathon_multi(rcp) then
        recipe.localised_description = {"", "✭ Ultra Marathon Recipe ", tostring(ultra_multi), "x"}

        recipe:clear_ingredients()
        for _, ing in pairs(ingredients) do
            if should_multiply_ingredients(ing) then
                local ing_amt = ing.amount or ing[2]
                local final_amt = mdpy.cap_amount(math.floor((ing_amt * ultra_multi) + 0.5))
                if ing.amount then ing.amount = final_amt else ing[2] = final_amt end
            end
        end
    end

    recipe.ingredients = ingredients

    if recipe.normal then
        recipe.normal.ingredients = ingredients
    end

    if recipe.expensive then
        recipe.expensive.ingredients = ingredients
    end
end