local pkg = {}
pkg.pipeline = {}
pkg.renderer = {}

function pkg.basic_config()
    vim.cmd [[
        call wilder#setup({
            \ 'modes': [':', '/', '?'],
            \ 'next_key': '<Tab>',
            \ 'previous_key': '<S-Tab>',
            \ 'accept_key': '<CR>',
            \ 'reject_key': '<C-/>',
            \ })
    ]]
end


-- For Neovim or Vim with yarp
-- For wild#cmdline_pipeline():
--   'language'   : set to 'python' to use python
--   'fuzzy'      : set fuzzy searching
-- For wild#python_search_pipeline():
--   'pattern'    : can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
--   'sorter'     : omit to get results in the order they appear in the buffer
--   'engine'     : can be set to 're2' for performance, requires pyre2 to be installed
function pkg.pipeline.config()
    vim.cmd [[
    call wilder#set_option('pipeline', [
          \   wilder#branch(
          \     wilder#python_file_finder_pipeline({
          \       'file_command': ['fd', '.', '--type', 'f'],
          \       'dir_command': ['fd', '.', '--type', 'd'],
          \       'filters': ['fuzzy_filter', 'difflib_sorter'],
          \     }),
          \     wilder#cmdline_pipeline({
          \       'language': 'python',
          \       'fuzzy': 1,
          \     }),
          \     wilder#python_search_pipeline({
          \       'pattern': wilder#python_fuzzy_pattern(),
          \       'sorter': wilder#python_difflib_sorter(),
          \       'engine': 're',
          \     }),
          \   ),
          \ ])
    ]]
end

function pkg.renderer.mux_config()
    vim.cmd [[
    call wilder#set_option('renderer', wilder#renderer_mux({
        \  '/': wilder#wildmenu_renderer({
        \    'separator': ' · ',
        \    'left': [' ', wilder#wildmenu_spinner(), ' '],
        \    'right': [' ', wilder#wildmenu_index()],
        \  }),
        \  ':': wilder#popupmenu_renderer({
        \    'highlighter': wilder#basic_highlighter(),
        \    'pumblend': 20,
        \  })
        \ })
    ]]
end

function pkg.renderer.add_border()
    vim.cmd [[
    " 'border'            : 'single', 'double', 'rounded' or 'solid'
    "                     : can also be a list of 8 characters
    " 'highlights.border' : highlight to use for the border`
    call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
          \ 'highlights': {
          \   'border': 'Normal',
          \ },
          \ 'border': 'rounded',
          \ })))
    ]]
end

function pkg.renderer.popup_config()
    vim.cmd [[
    call wilder#set_option('renderer', wilder#popupmenu_renderer({
          \ 'highlighter': [
          \   wilder#lua_pcre2_highlighter(),
          \   wilder#lua_fzy_highlighter(),
          \ ],
          \ 'highlights': {
          \   'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),
          \ },
          \ 'left': [
          \   ' ', wilder#popupmenu_devicons(),
          \ ],
          \ 'right': [
          \   ' ', wilder#popupmenu_scrollbar(),
          \ ],
          \ }))
    ]]
end

--- Advanced config suggested on GH homepage
-- Requires:
--      * fd
--      * nixprime/cpsm
--      * fzy-lua-native
--      * nvim-web-devicons
function pkg.advanced_config()
    vim.cmd [[
    call wilder#setup({'modes': [':', '/', '?']})

    call wilder#set_option('pipeline', [
          \   wilder#branch(
          \     wilder#python_file_finder_pipeline({
          \       'file_command': {_, arg -> stridx(arg, '.') != -1 ? ['fd', '-tf', '-H'] : ['fd', '-tf']},
          \       'dir_command': ['fd', '-td'],
          \       'filters': ['cpsm_filter'],
          \     }),
          \     wilder#substitute_pipeline({
          \       'pipeline': wilder#python_search_pipeline({
          \         'skip_cmdtype_check': 1,
          \         'pattern': wilder#python_fuzzy_pattern({
          \           'start_at_boundary': 0,
          \         }),
          \       }),
          \     }),
          \     wilder#cmdline_pipeline({
          \       'fuzzy': 1,
          \       'fuzzy_filter': has('nvim') ? wilder#lua_fzy_filter() : wilder#vim_fuzzy_filter(),
          \     }),
          \     [
          \       wilder#check({_, x -> empty(x)}),
          \       wilder#history(),
          \     ],
          \     wilder#python_search_pipeline({
          \       'pattern': wilder#python_fuzzy_pattern({
          \         'start_at_boundary': 0,
          \       }),
          \     }),
          \   ),
          \ ])

    let s:highlighters = [
          \ wilder#pcre2_highlighter(),
          \ has('nvim') ? wilder#lua_fzy_highlighter() : wilder#cpsm_highlighter(),
          \ ]

    let s:popupmenu_renderer = wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
          \ 'border': 'rounded',
          \ 'pumblend': 40,
          \ 'empty_message': wilder#popupmenu_empty_message_with_spinner(),
          \ 'highlighter': s:highlighters,
          \ 'left': [
          \   ' ',
          \   wilder#popupmenu_devicons(),
          \   wilder#popupmenu_buffer_flags({
          \     'flags': ' a + ',
          \     'icons': {'+': '', 'a': '', 'h': ''},
          \   }),
          \ ],
          \ 'right': [
          \   ' ',
          \   wilder#popupmenu_scrollbar(),
          \ ],
          \ }))

    let s:wildmenu_renderer = wilder#wildmenu_renderer({
          \ 'highlighter': s:highlighters,
          \ 'separator': ' · ',
          \ 'left': [' ', wilder#wildmenu_spinner(), ' '],
          \ 'right': [' ', wilder#wildmenu_index()],
          \ })

    call wilder#set_option('renderer', wilder#renderer_mux({
          \ ':': s:popupmenu_renderer,
          \ '/': s:wildmenu_renderer,
          \ 'substitute': s:wildmenu_renderer,
          \ }))
    ]]
end

return pkg
