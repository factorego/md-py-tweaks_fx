-- Overrides the value of an existing setting. Adapted from similar method in SeaBlock
--
-- @param setting_type the type of setting (bool-setting | int-setting | double-setting | string-setting)
function mdpy.override_setting(setting_type, setting_name, value)
    if data.raw[setting_type] then
        local setting = data.raw[setting_type][setting_name]
        if setting then
            if setting_type == "bool-setting" then
                setting.forced_value = value
            else
                setting.default_value = value
                setting.allowed_values = { value }
            end
            setting.hidden = true
        else
            log("Error: missing setting " .. setting_name)
        end
    else
        log("Error: missing setting type " .. setting_type)
    end
end


if mods['cargo-ships'] then
    require('settings-updates/cargo-ships')
end

if mods["SpaceMod"] then
    require('settings-updates/spacemod')
end