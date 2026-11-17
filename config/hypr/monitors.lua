-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List monitors and their modes with: hyprctl monitors all

-- The internal panel is 1440x900 at 13.3", so no scaling.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
