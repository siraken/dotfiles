local wezterm = require("wezterm")

local M = {}

-- Spotify information cache
local spotify_cache = {
  last_update = 0,
  track = "",
  artist = "",
  is_playing = false,
  is_available = false,
}

-- Cache duration in seconds
local CACHE_DURATION = 5

-- Get Spotify status using AppleScript (macOS only)
local function get_spotify_status()
  local current_time = os.time()

  -- Return cached data if still valid
  if current_time - spotify_cache.last_update < CACHE_DURATION then
    return spotify_cache
  end

  local ok, _ = pcall(function()
    -- Check if Spotify is running
    local running_ok, running_stdout, _ = wezterm.run_child_process({
      "osascript",
      "-e",
      'tell application "System Events" to (name of processes) contains "Spotify"',
    })

    if not running_ok or not running_stdout or running_stdout:match("false") then
      spotify_cache.is_available = false
      spotify_cache.last_update = current_time
      return
    end

    -- Get current track information with a single AppleScript call
    local info_ok, info_stdout, _ = wezterm.run_child_process({
      "osascript",
      "-e",
      [[
        tell application "Spotify"
          if player state is playing then
            set trackName to name of current track
            set artistName to artist of current track
            return trackName & " by " & artistName & "|playing"
          else if player state is paused then
            set trackName to name of current track
            set artistName to artist of current track
            return trackName & " by " & artistName & "|paused"
          else
            return "No track|stopped"
          end if
        end tell
      ]],
    })

    if not info_ok or not info_stdout then
      spotify_cache.is_available = false
      spotify_cache.last_update = current_time
      return
    end

    local output = info_stdout:gsub("%s+$", "")
    local track_artist, state = output:match("(.+)|(.+)")

    if track_artist and state then
      local track, artist = track_artist:match("(.+) by (.+)")

      spotify_cache.track = track or "Unknown Track"
      spotify_cache.artist = artist or "Unknown Artist"
      spotify_cache.is_playing = (state == "playing")
      spotify_cache.is_available = true
    else
      spotify_cache.is_available = false
    end

    spotify_cache.last_update = current_time
  end)

  if not ok then
    spotify_cache.is_available = false
    spotify_cache.last_update = current_time
  end

  return spotify_cache
end

-- Format track name for display (truncate if too long)
local function format_track_display(track, artist, max_length)
  max_length = max_length or 30
  local full_text = track .. " - " .. artist

  if #full_text <= max_length then
    return full_text
  end

  -- Try truncating artist first
  local truncated = track .. " - " .. artist:sub(1, max_length - #track - 5) .. "..."
  if #truncated <= max_length then
    return truncated
  end

  -- Truncate track if still too long
  return track:sub(1, max_length - 3) .. "..."
end

-- Get Spotify display information
function M.get_spotify_info()
  local status = get_spotify_status()

  if not status.is_available then
    return nil
  end

  return {
    track = status.track,
    artist = status.artist,
    is_playing = status.is_playing,
    display_text = format_track_display(status.track, status.artist),
    icon = status.is_playing and "󰐊" or "󰏤",
  }
end

-- Get Spotify status for status bar
function M.get_status_element()
  local info = M.get_spotify_info()

  if not info then
    return nil
  end

  return {
    icon = info.icon,
    text = info.display_text,
    color = info.is_playing and "#1DB954" or "#B3B3B3",
  }
end

return M
