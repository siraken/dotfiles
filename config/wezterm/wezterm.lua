-- Modules that only register event handlers (status bar, events, tab titles)
require("status")
require("event")
require("format")

local wezterm = require("wezterm")
local utils = require("utils")
local keybinds = require("keybinds")
local mouse_bindings = require("mousebinds")

local is_darwin = utils.is_darwin
local is_windows = utils.is_windows

-- WSL distribution new panes open in on Windows. Falls back to the first
-- distribution that is not Docker Desktop's when it is not installed.
local PREFERRED_WSL_DISTRO = "Ubuntu"

local function pick_wsl_domain(domains)
  for _, domain in ipairs(domains) do
    if domain.distribution == PREFERRED_WSL_DISTRO then
      return domain.name
    end
  end
  for _, domain in ipairs(domains) do
    if not domain.distribution:find("^docker%-desktop") then
      return domain.name
    end
  end
  return nil
end

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
local config = wezterm.config_builder and wezterm.config_builder() or {}

-- General ----------------------------------------------------------------

config.automatically_reload_config = true
config.default_prog = { "bash", "-l" }
config.exit_behavior = "Close"
config.status_update_interval = 1000
config.use_ime = true

-- Keys & mouse -----------------------------------------------------------

config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = keybinds.keys
config.key_tables = keybinds.key_tables
config.mouse_bindings = mouse_bindings

-- Platform-specific ------------------------------------------------------
-- Must come before anything derived from font_size (e.g. the command palette).

if is_darwin then
  config.font_size = 16
  config.line_height = 1.2
  config.window_background_opacity = 0.7
  config.macos_window_background_blur = 13
  config.window_decorations = "RESIZE"
  -- config.macos_window_dragging_behavior = "all"
elseif is_windows then
  -- Open panes in WezTerm's WSL domain instead of running wsl.exe as a Windows
  -- program: WezTerm then knows the Linux cwd (reported via OSC 7, see
  -- config/bash/osc7.sh) and new tabs / splits open in the same directory.
  local wsl_domains = wezterm.default_wsl_domains()
  for _, domain in ipairs(wsl_domains) do
    domain.default_prog = { "bash", "-l" }
  end
  config.wsl_domains = wsl_domains
  config.default_domain = pick_wsl_domain(wsl_domains)
  -- Windows shells stay reachable from the launcher (Alt+L)
  config.launch_menu = {
    { label = "PowerShell", domain = { DomainName = "local" }, args = { "powershell.exe", "-NoLogo" } },
  }
  -- Points are rendered at 96 dpi here but 72 dpi on macOS, so 12 matches the
  -- pixel size of the Mac's 16 on the same 1080p display.
  config.font_size = 12
  config.line_height = 1.2
  -- The default caps rendering at 60 fps; match the 164 Hz main display
  config.max_fps = 164
  config.animation_fps = 164
  -- Plain see-through without a backdrop: Acrylic blurs far more than the
  -- Mac's blur of 13 (and its strength is not configurable), while Mica does
  -- not show what is behind the window at all.
  config.window_background_opacity = 0.95
  config.win32_system_backdrop = "Disable"
else
  config.font_size = 14
  config.line_height = 1.2
  config.window_background_opacity = 0.85
  config.window_decorations = "RESIZE"
end

-- Colors -----------------------------------------------------------------

config.color_scheme = "Tokyo Night"
config.colors = {
  scrollbar_thumb = "white",
  tab_bar = {
    background = "none",
    inactive_tab_edge = "none",
  },
}

-- Font -------------------------------------------------------------------

local function font(family)
  return { family = family, weight = "Regular", style = "Normal", stretch = "Normal" }
end

config.font = wezterm.font_with_fallback({
  font("Hack Nerd Font Mono"),
  -- font("Hack NF"),
  font("Consolas"),
  font("Courier New"),
  font("JetBrains Mono"),
  font("Hiragino Sans"),
  font("Noto Sans JP"),
})
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.adjust_window_size_when_changing_font_size = false

-- Tab bar ----------------------------------------------------------------

config.enable_tab_bar = true
-- タブの管理は herdr に任せるので、wezterm 側が 1 タブのときはタブバーごと隠す。
-- status.lua の right status もタブバーに描かれるため一緒に消える。
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 32
-- config.show_close_tab_button_in_tabs = false

-- Command palette --------------------------------------------------------

config.command_palette_font_size = config.font_size * 1.5
config.command_palette_rows = 10
config.command_palette_bg_color = "#16161e"

-- Window -----------------------------------------------------------------

config.enable_scroll_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}
config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.3,
}

return config
