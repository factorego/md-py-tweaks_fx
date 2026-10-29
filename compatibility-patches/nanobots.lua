-- Run the Pyanodons Post-processing fix_tech method on all techs to bring costs and prerequisites in line.
fix_tech("nanobots",{order="000005",prerequisites={"automation"},unit={count=30,ingredients={{"automation-science-pack",1}},time=30}})
fix_tech("nano-speed-1",{order="000006",prerequisites={"nanobots"},unit={count=33,ingredients={{"automation-science-pack",1}},time=30}})
fix_tech("nano-range-1",{order="000006",prerequisites={"nanobots"},unit={count=33,ingredients={{"automation-science-pack",1}},time=30}})
fix_tech("nano-speed-2",{order="000012",prerequisites={"logistics", "nano-speed-1"},unit={count=90,ingredients={{"automation-science-pack",1}},time=30}})
fix_tech("nano-range-2",{order="000012",prerequisites={"logistics", "nano-range-1"},unit={count=90,ingredients={{"automation-science-pack",1}},time=30}})
fix_tech("nano-speed-3",{order="000023",prerequisites={"automation-2", "nano-speed-2"},unit={count=100,ingredients={{"automation-science-pack",2},{"py-science-pack-1",1}},time=45}})
fix_tech("nano-range-3",{order="000023",prerequisites={"automation-2", "nano-range-2"},unit={count=100,ingredients={{"automation-science-pack",2},{"py-science-pack-1",1}},time=45}})
fix_tech("nano-speed-4",{order="000032",prerequisites={"battery-mk01", "nano-speed-3"},unit={count=330,ingredients={{"automation-science-pack",2},{"py-science-pack-1",1}},time=45}})
fix_tech("nano-range-4",{order="000032",prerequisites={"battery-mk01", "nano-range-3"},unit={count=330,ingredients={{"automation-science-pack",2},{"py-science-pack-1",1}},time=45}})
fix_tech("nanobots-cliff",{order="000049",prerequisites={"cliff-explosives","nanobots"},unit={count=1000,ingredients={{"automation-science-pack",3},{"logistic-science-pack",1},{"py-science-pack-1",2}},time=60}})

-- Make the nano emitter cost materials that can be crafted at the start of the game.
RECIPE("gun-nano-emitter")
        :clear_ingredients()
        :add_ingredient({type = "item", name = "copper-plate", amount = 5})
        :add_ingredient({type = "item", name = "wood", amount = 5})
        :add_ingredient({type = "item", name = "small-parts-01", amount = 10})
        :add_ingredient({type = "item", name = "inductor1", amount = 10})

-- Make termite bots cost early game materials
RECIPE("ammo-nano-termites")
        :clear_ingredients()
        :add_ingredient({type = "item", name = "inductor1", amount = 1})
        :add_ingredient({type = "item", name = "small-parts-01", amount = 1})