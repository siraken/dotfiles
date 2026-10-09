local wezterm = require("wezterm")

local M = {}

-- Cache duration in seconds
local CACHE_DURATION = 5

local IS_RUNNING_SCRIPT = 'tell application "System Events" to (name of processes) contains "Spotify"'

-- Prints "<track> by <artist>|<playing|paused|stopped>"
local TRACK_INFO_SCRIPT = [[
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
      ]]

-- Spotify information cache
local spotify_cache = {
  last_update = 0,
  track = "",
  artist = "",
  is_playing = false,
  is_available = false,
}

local function osascript(script)
  return wezterm.run_child_process({ "osascript", "-e", script })
end

-- Query Spotify via AppleScript (macOS only).
-- Returns { track, artist, is_playing }, or nil when it is unavailable.
local function fetch_spotify_status()
  local running_ok, running_stdout = osascript(IS_RUNNING_SCRIPT)
  if not running_ok or not running_stdout or running_stdout:match("false") then
    return nil
  end

  local info_ok, info_stdout = osascript(TRACK_INFO_SCRIPT)
  if not info_ok or not info_stdout then
    return nil
  end

  local output = info_stdout:gsub("%s+$", "")
  local track_artist, state = output:match("(.+)|(.+)")
  if not (track_artist and state) then
    return nil
  end

  local track, artist = track_artist:match("(.+) by (.+)")
  return {
    track = track or "Unknown Track",
    artist = artist or "Unknown Artist",
    is_playing = (state == "playing"),
  }
end

-- Get Spotify status, refreshed at most once per CACHE_DURATION
local function get_spotify_status()
  local current_time = os.time()

  -- Return cached data if still valid
  if current_time - spotify_cache.last_update < CACHE_DURATION then
    return spotify_cache
  end

  local ok, status = pcall(fetch_spotify_status)
  if ok and status then
    spotify_cache.track = status.track
    spotify_cache.artist = status.artist
    spotify_cache.is_playing = status.is_playing
    spotify_cache.is_available = true
  else
    spotify_cache.is_available = false
  end
  spotify_cache.last_update = current_time

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

return M
