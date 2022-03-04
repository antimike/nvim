-- NOTE: This is just illustration - there is no need to copy/paste the
-- defaults, or call `setup` at all, if you do not want to change anything.
local wk = require("which-key")

require'lightspeed'.setup {
  ignore_case = false,
  exit_after_idle_msecs = { unlabeled = 1000, labeled = nil },
  --- s/x ---
  jump_to_unique_chars = { safety_timeout = 400 },
  match_only_the_start_of_same_char_seqs = true,
  force_beacons_into_match_width = false,
  -- Display characters in a custom way in the highlighted matches.
  substitute_chars = { ['\r'] = '¬', },
  -- Leaving the appropriate list empty effectively disables "smart" mode,
  -- and forces auto-jump to be on or off.
  -- safe_labels = { . . . },
  -- labels = { . . . },
  -- These keys are captured directly by the plugin at runtime.
  special_keys = {
    next_match_group = '<space>',
    prev_match_group = '<tab>',
  },
  --- f/t ---
  limit_ft_matches = 4,
  repeat_ft_with_target_char = false,
}

local all_modes = {
        f = {"Jump to character (forward)"},
        F = {"Jump to character (backward)"},
        t = {"Jump to predecessor of character (forward)"},
        T = {"Jump to predecessor of character (backward)"},
}

wk.register({
        s = {"Jump to bigram (forward)"},
        S = {"Jump to bigram (backward)"},
        gs = {"Jump to bigram (successor windows)"},
        gS = {"Jump to bigram (predecessor windows)"}
}, {mode = "n"})

wk.register({
        s = {"Extend selection to bigram (forward)"},
        S = {"Extend selection to bigram (backward)"},
}, {mode = "v"})

for _, mode in ipairs {"n", "v", "o", "x"} do
        wk.register(all_modes, {mode = mode})
end

