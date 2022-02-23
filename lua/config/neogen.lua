local ng = require("neogen")

ng.setup {
    enabled = true,
    input_after_comment = true,
    -- For illustrative purposes:
    languages = {
        lua = {
            template = {
                annotation_convention = "emmylua"
            }
        }
    }
}
