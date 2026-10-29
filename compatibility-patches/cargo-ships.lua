-- Run the Pyanodons Post-processing fix_tech method on all techs to bring costs and prerequisites in line.
fix_tech("water_transport",{order="000010",prerequisites={"electronics"},unit={count=55,ingredients={{"automation-science-pack",1}},time=30}})
fix_tech("oversea-energy-distribution",{order="000043",prerequisites={"water_transport", "electric-energy-distribution-2"},unit={count=400,ingredients={{"automation-science-pack",3},{"py-science-pack-1",2},{"logistic-science-pack",1}},time=60}})
fix_tech("automated_water_transport",{order="000024",prerequisites={"water_transport", "automation-2"},unit={count=110,ingredients={{"automation-science-pack",2},{"py-science-pack-1",1}},time=45}})
fix_tech("cargo_ships",{order="000025",prerequisites={"automated_water_transport"},unit={count=110,ingredients={{"automation-science-pack",2},{"py-science-pack-1",1}},time=45}})
fix_tech("tank_ship",{order="000025",prerequisites={"automated_water_transport"},unit={count=110,ingredients={{"automation-science-pack",2},{"py-science-pack-1",1}},time=45}})
fix_tech("automated_bridges",{order="000033",prerequisites={"automated_water_transport", "automated-rail-transportation", "machine-components-mk01"},unit={count=340,ingredients={{"automation-science-pack",2},{"py-science-pack-1",1}},time=45}})

-- Bring the cargo ship recipe in line with the cost of a locomotive plus 3 cargo wagons.
-- This number was chosen based on the loading bandwidth and movement speed of the ship.
RECIPE("cargo_ship")
        :clear_ingredients()
        :add_ingredient({type = "item", name = "pipe", amount = 40})
        :add_ingredient({type = "item", name = "steam-engine", amount = 4})
        :add_ingredient({type = "item", name = "pump", amount = 4})
        :add_ingredient({type = "item", name = "intermetallics", amount = 20})
        :add_ingredient({type = "item", name = "brake-mk01", amount = 10})
        :add_ingredient({type = "item", name = "gearbox-mk01", amount = 1})
        :add_ingredient({type = "item", name = "shaft-mk01", amount = 10})
        :add_ingredient({type = "item", name = "electronic-circuit", amount = 10})
        :add_ingredient({type = "item", name = "small-parts-01", amount = 50})
        :add_ingredient({type = "item", name = "steel-plate", amount = 90})
        :add_ingredient({type = "item", name = "duralumin", amount = 55})
        :add_ingredient({type = "item", name = "titanium-plate", amount = 150})
        :add_ingredient({type = "item", name = "iron-plate", amount = 60})

-- Bring the oil tanker recipe in line with the cost of a locomotive plus 1 fluid wagon
RECIPE('oil_tanker')
        :clear_ingredients()
        :add_ingredient({type = "item", name = "pipe", amount = 60})
        :add_ingredient({type = "item", name = "storage-tank", amount = 10})
        :add_ingredient({type = "item", name = "steam-engine", amount = 4})
        :add_ingredient({type = "item", name = "pump", amount = 4})
        :add_ingredient({type = "item", name = "intermetallics", amount = 10})
        :add_ingredient({type = "item", name = "brake-mk01", amount = 6})
        :add_ingredient({type = "item", name = "gearbox-mk01", amount = 1})
        :add_ingredient({type = "item", name = "shaft-mk01", amount = 6})
        :add_ingredient({type = "item", name = "electronic-circuit", amount = 10})
        :add_ingredient({type = "item", name = "small-parts-01", amount = 30})
        :add_ingredient({type = "item", name = "steel-plate", amount = 50})
        :add_ingredient({type = "item", name = "duralumin", amount = 35})
        :add_ingredient({type = "item", name = "titanium-plate", amount = 50})
        :add_ingredient({type = "item", name = "iron-plate", amount = 20})

-- Pyify the lifting train bridge recipe by introducing advanced components.
RECIPE('bridge_base')
        :clear_ingredients()
        :add_ingredient({type = "item", name = "straight-rail", amount = 10})
        :add_ingredient({type = "item", name = "mechanical-parts-01", amount = 1})
        :add_ingredient({type = "item", name = "small-parts-01", amount = 30})
        :add_ingredient({type = "item", name = "steel-plate", amount = 40})
        :add_ingredient({type = "item", name = "titanium-plate", amount = 20})

-- Update the engine to accept a multitude of fuels.
data.raw.locomotive.cargo_ship_engine.energy_source.fuel_categories = {"chemical", "biomass", "nuke", "nuclear"}