local utils = require("utils")

require("auto-session").setup {
        auto_session_enabled = false,   -- Applies to both save / restore
        auto_restore_enabled = false,
        auto_save_enabled = true,
        bypass_session_save_file_types = utils.blacklist.filetypes,
        auto_session_enable_last_session = false,
        log_level = "info",
}
