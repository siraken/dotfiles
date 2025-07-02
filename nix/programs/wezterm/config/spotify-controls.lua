local wezterm = require("wezterm")

local M = {}

-- Spotify control functions
function M.play_pause()
  wezterm.run_child_process({
    "osascript",
    "-e",
    'tell application "Spotify" to playpause'
  })
end

function M.next_track()
  wezterm.run_child_process({
    "osascript",
    "-e",
    'tell application "Spotify" to next track'
  })
end

function M.previous_track()
  wezterm.run_child_process({
    "osascript",
    "-e",
    'tell application "Spotify" to previous track'
  })
end

function M.volume_up()
  wezterm.run_child_process({
    "osascript",
    "-e",
    'tell application "Spotify" to set sound volume to (sound volume + 10)'
  })
end

function M.volume_down()
  wezterm.run_child_process({
    "osascript",
    "-e",
    'tell application "Spotify" to set sound volume to (sound volume - 10)'
  })
end

-- Show current track information
function M.show_track_info()
  local spotify = require("spotify")
  local info = spotify.get_spotify_info()

  if info then
    local status = info.is_playing and "Playing" or "Paused"
    local message = string.format("%s: %s - %s", status, info.track, info.artist)

    -- Get the current window and show notification
    local window = wezterm.mux.get_active_window()
    if window then
      window:toast_notification("Spotify", message, nil, 3000)
    end
  else
    local window = wezterm.mux.get_active_window()
    if window then
      window:toast_notification("Spotify", "Spotify is not running", nil, 2000)
    end
  end
end

return M
