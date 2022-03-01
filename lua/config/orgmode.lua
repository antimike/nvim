local org = require('orgmode')

-- Load custom tree-sitter grammar for org filetype
org.setup_ts_grammar()

org.setup {
    org_agenda_files = {
        '~/notes/*.org',
    },
    org_default_notes_file ='~/notes/index.org',
}
