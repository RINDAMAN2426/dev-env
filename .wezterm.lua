local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

config.color_scheme = 'Gruvbox Dark (Gogh)'
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font 'JetBrains Mono'
config.window_decorations = 'RESIZE'

config.keys = {
  -- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f respectively to match Terminal.app behavior
  {
    key = 'LeftArrow',
    mods = 'OPT',
    action = act.SendKey {
      key = 'b',
      mods = 'ALT',
    },
  },
  {
    key = 'RightArrow',
    mods = 'OPT',
    action = act.SendKey { key = 'f', mods = 'ALT' },
  },
}

return config