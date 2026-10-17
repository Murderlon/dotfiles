-- Keep only your personal input overrides here. Uncommented settings below
-- replace Omarchy's defaults.

-- Keyboard layout and options.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
  input = {
    --     -- Use multiple keyboard layouts and switch between them with Left Alt + Right Alt.
    --     kb_layout = "us,dk,eu",
    --     kb_options = "compose:caps,shift:both_capslock_cancel,grp:alts_toggle",
    --
    --     -- Use a specific keyboard variant if needed (e.g. intl for international keyboards).
    kb_variant = "altgr-intl",
    --
    --     -- Change speed of keyboard repeat.
    kb_options = "caps:escape,shift:both_capslock_cancel",
    --     repeat_rate = 40,
    --     repeat_delay = 250,
    --
    --     -- Start with numlock on by default.
    --     numlock_by_default = true,
    --
    --     -- Increase sensitivity for mouse/trackpad (default: 0).
    sensitivity = -0.7,
    --
    --     -- Invert the scroll wheel direction for external mice.
    scroll_factor = -1,
    --
    --     -- Turn off mouse acceleration (default: adaptive).
    --     accel_profile = "flat",
    --
    --     touchpad = {
    --       -- Use natural (inverse) scrolling.
    --       natural_scroll = true,
    --
    --       -- Use two-finger clicks for right-click instead of lower-right corner.
    --       clickfinger_behavior = true,
    --
    --       -- Control the speed of your scrolling.
    --       scroll_factor = 0.4,
    --
    --       -- Enable the touchpad while typing.
    --       disable_while_typing = false,
    --
    --       -- Left-click-and-drag with three fingers.
    --       drag_3fg = 1,
    --     },
  },
})

-- Swap Left Alt and Left Super only on the Keychron keyboard.
-- The Keychron mouse/receiver and any other keyboard keep the global layout.
hl.device({
  name = "keychron--keychron-link--keyboard",
  kb_options = "caps:escape,shift:both_capslock_cancel,altwin:swap_lalt_lwin",
})

-- Kinesis only: Caps Lock acts as AltGr; Home keeps its normal behavior.
hl.device({
  name = "kinesis-advantage2-keyboard-1",
  kb_options = "lv3:caps_switch,shift:both_capslock_cancel",
})

-- App-specific touchpad scroll speeds.
-- o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.5 })
-- o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })

-- Enable touchpad gestures for changing workspaces.
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
-- hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Enable touchpad gestures for moving focus (helpful on scrolling layout).
-- hl.gesture({ fingers = 3, direction = "left", action = function() hl.dispatch(hl.dsp.focus({ direction = "l" })) end })
-- hl.gesture({ fingers = 3, direction = "right", action = function() hl.dispatch(hl.dsp.focus({ direction = "r" })) end })
