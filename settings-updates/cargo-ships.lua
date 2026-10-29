-- Hide settings related to offshore oil.
mdpy.override_setting("bool-setting", "deep_oil", false)
mdpy.override_setting("string-setting", "oil_richness", "very-poor")
mdpy.override_setting("bool-setting", "no_oil_for_oil_rig", false)
mdpy.override_setting("int-setting", "oil_rig_capacity", 100)
mdpy.override_setting("bool-setting", "no_oil_on_land", false)
mdpy.override_setting("bool-setting", "no_shallow_oil", true)
mdpy.override_setting("string-setting", "oil_rigs_require_external_power", "only-when-moduled")
mdpy.override_setting("bool-setting", "offshore_oil_enabled", false)