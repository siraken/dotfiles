-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
-- Omarchy's defaults, with the overrides its own input.lua had.

hl.config({
  input = {
    kb_layout = "us",
    -- CapsLock is compose; both Shifts toggle Caps Lock, and a lone Shift
    -- afterwards releases it.
    kb_options = "compose:caps,shift:both_capslock_cancel",

    repeat_rate = 40,
    repeat_delay = 250,
    numlock_by_default = true,

    sensitivity = 0.35,
    accel_profile = "flat",

    -- Click to focus: hovering only sends pointer events.
    follow_mouse = 2,

    natural_scroll = true,

    touchpad = {
      natural_scroll = true,
      -- Two-finger click is a right-click.
      clickfinger_behavior = true,
      -- Tuned by feel on the machine: 0.3 scrolled a little too far.
      scroll_factor = 0.22,
      -- Ignore the touchpad while typing, so a palm cannot tap-click.
      disable_while_typing = true,
      -- Tap-to-click stays, but a tap no longer starts a drag: a stray touch
      -- right after a tap selected or moved things. Light brushes are kept out
      -- by the touch size threshold (nix/hosts/siraken-mba/hardware.nix).
      tap_and_drag = false,
      drag_3fg = 0,
    },
  },

  misc = {
    key_press_enables_dpms = true,
    mouse_move_enables_dpms = true,
  },
})

-- Three-finger horizontal swipe switches workspaces, as on the Mac. The
-- defaults (inverted, 300px per workspace) feel right on this touchpad.
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Only the MacBook's own JIS keyboard is jp; external keyboards stay us.
hl.device({ name = "apple-inc.-apple-internal-keyboard-/-trackpad", kb_layout = "jp" })

-- Scroll speed in terminals. This replaces scroll_factor for the window
-- rather than multiplying it, so it was lowered by the same ratio.
o.window("org.wezfurlong.wezterm", { scroll_touchpad = 1.1 })
