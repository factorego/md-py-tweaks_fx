mdpy = mdpy or {}

data:extend({
  {
    type = "bool-setting",
    name = "mdpy-cargo-ships-compatibility",
    setting_type = "startup",
    default_value = false,
    order = "aa"
  },
  {
      type = "bool-setting",
      name = "mdpy-container-cargo-ship-compatibility",
      setting_type = "startup",
      default_value = false,
      order = "aaa"
    },
  {
    type = "bool-setting",
    name = "mdpy-nanobots-compatibility",
    setting_type = "startup",
    default_value = false,
    order = "ab"
  },
  {
    type = "bool-setting",
    name = "mdpy-miniloader-compatibility",
    setting_type = "startup",
    default_value = false,
    order = "ac"
  },
  {
    type = "bool-setting",
    name = "mdpy-shield-projector-compatibility",
    setting_type = "startup",
    default_value = false,
    order = "ad"
  },
  {
    type = "bool-setting",
    name = "mdpy-dectorio-compatibility",
    setting_type = "startup",
    default_value = false,
    order = "ae"
  },
  {
    type = "bool-setting",
    name = "mdpy-spacemod-compatibility",
    setting_type = "startup",
    default_value = false,
    order = "af"
  },
  {
    type = "bool-setting",
    name = "mdpy-spacemod-hardcore",
    setting_type = "startup",
    default_value = false,
    order = "afa"
  },
  {
    type = "bool-setting",
    name = "mdpy-robo-start",
    setting_type = "startup",
    default_value = false,
    order = "afb"
  },
  {
    type = "bool-setting",
    name = "mdpy-military-start",
    setting_type = "startup",
    default_value = false,
    order = "afc"
  },
  {
    type = "bool-setting",
    name = "mdpy-pyblock-start",
    setting_type = "startup",
    default_value = false,
    order = "afd"
  },
  {
    type = "bool-setting",
    name = "mdpy-marathon",
    setting_type = "startup",
    default_value = false,
    order = "ca"
  },
  {
    type = "double-setting",
    name = "mdpy-marathon-multi",
    setting_type = "startup",
    minimum_value = 1.0,
    default_value = 2.0,
    order = "cb"
  },
  {
    type = "bool-setting",
    name = "mdpy-marathon-plus",
    setting_type = "startup",
    default_value = false,
    order = "cc"
  },
  {
    type = "bool-setting",
    name = "mdpy-tech-marathon",
    setting_type = "startup",
    default_value = false,
    order = "cd"
  },
  {
    type = "bool-setting",
    name = "mdpy-ultra-marathon",
    setting_type = "startup",
    default_value = false,
    order = "ce"
  },
  {
    type = "double-setting",
    name = "mdpy-ultra-marathon-multi",
    setting_type = "startup",
    minimum_value = 1.0,
    default_value = 1.45,
    order = "cf"
  },
  {
    type = "string-setting",
    name = "mdpy-marathon-blocklist",
    setting_type = "startup",
    default_value = "",
    allow_blank = true,
    order = "cg"
  },
  {
    type = "string-setting",
    name = "mdpy-marathon-ing-blocklist",
    setting_type = "startup",
    default_value = "",
    allow_blank = true,
    order = "ch"
  },
})