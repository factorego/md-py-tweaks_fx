require('functions')

if mods["cargo-ships"] and settings.startup["mdpy-cargo-ships-compatibility"].value == true then
    require("compatibility-patches.cargo-ships")
end

if mods["container-cargo-ship"] and settings.startup["mdpy-container-cargo-ship-compatibility"].value == true then
    require("compatibility-patches.container-cargo-ship")
end

if mods["Nanobots2"] and settings.startup["mdpy-nanobots-compatibility"].value == true then
    require("compatibility-patches.nanobots")
end

if mods["miniloader-redux"] and settings.startup["mdpy-miniloader-compatibility"].value == true then
    require("compatibility-patches.miniloader")
end

if mods["shield-projector"] and settings.startup["mdpy-shield-projector-compatibility"].value == true then
    require("compatibility-patches.shield-projector")
end

if mods["Dectorio"] and settings.startup["mdpy-dectorio-compatibility"].value == true then
    require("compatibility-patches.dectorio")
end

if mods["SpaceModFeorasFork"] and settings.startup["mdpy-spacemod-compatibility"].value == true then
    require("compatibility-patches.spacemod")
end

if settings.startup["mdpy-marathon"].value == true or settings.startup["mdpy-ultra-marathon"].value == true then
    require("marathon.recipe-updates")
end

if settings.startup["mdpy-robo-start"].value == true then
    require("starting-robots.technology-updates")
end

require("mapgens.mapgen")