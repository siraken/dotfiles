local wezterm = require("wezterm")
local spotify = require("spotify")

local M = {}

local function tell_spotify(command)
  wezterm.run_child_process({
    "osascript",
    "-e",
    'tell application "Spotify" to ' .. command,
  })
end

-- Spotify control functions
function M.play_pause()
  tell_spotify("playpause")
end

function M.next_track()
  tell_spotify("next track")
end

function M.previous_track()
  tell_spotify("previous track")
end

function M.volume_up()
  tell_spotify("set sound volume to (sound volume + 10)")
end

function M.volume_down()
  tell_spotify("set sound volume to (sound volume - 10)")
end

-- Show current track information
function M.show_track_info()
  local info = spotify.get_spotify_info()

  local window = wezterm.mux.get_active_window()
  if not window then
    return
  end

  if info then
    local status = info.is_playing and "Playing" or "Paused"
    local message = string.format("%s: %s - %s", status, info.track, info.artist)
    window:toast_notification("Spotify", message, nil, 3000)
  else
    window:toast_notification("Spotify", "Spotify is not running", nil, 2000)
  end
end

return M
