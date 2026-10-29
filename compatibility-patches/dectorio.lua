fix_tech("dect-lawnmower",{order="000006",prerequisites={"engine", "dect-landscaping"},unit={count=33, ingredients={{"automation-science-pack",1}},time=30}})

-- Make the coal tile return raw coal and not regular coal
data.raw["tile"]["dect-coal-gravel"].minable = {mining_time = 0.1, result = "raw-coal"}
