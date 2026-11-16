-- Helpers shared by the other modules (a small subset of Omarchy's
-- default/hypr/helpers.lua).

local home = os.getenv("HOME")

o = {}

o.dir = home .. "/.config/hypr-nixos"

local function shell_quote(value)
  return "'" .. tostring(value):gsub("'", "'\\''") .. "'"
end

o.shell_quote = shell_quote

-- Start an app as its own systemd unit under UWSM, not as a child of Hyprland.
function o.launch(command)
  return "uwsm-app -- " .. command
end

-- A script in ./scripts.
function o.script(name, args)
  return o.dir .. "/scripts/" .. name .. (args and (" " .. args) or "")
end

function o.bind(keys, description, dispatcher, options)
  local opts = options or {}

  if description then
    opts.description = description
  end

  if type(dispatcher) == "string" then
    dispatcher = hl.dsp.exec_cmd(dispatcher)
  end

  hl.bind(keys, dispatcher, opts)
end

function o.window(match, rules)
  rules.match = rules.match or {}

  if type(match) == "string" then
    rules.match.class = match
  else
    for key, value in pairs(match) do
      rules.match[key] = value
    end
  end

  hl.window_rule(rules)
end

function o.launch_on_start(command)
  hl.on("hyprland.start", function()
    hl.exec_cmd(o.launch(command))
  end)
end
