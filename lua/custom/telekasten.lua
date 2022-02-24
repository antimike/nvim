local pkg = {}

function pkg.StyleLinks(style)
    style = style or "BLUEGREY"
    style = style:upper()
    if style == "BLUEGREY" then
        vim.cmd [[
        " just blue and gray links
        hi tkLink ctermfg=Blue cterm=bold,underline guifg=blue gui=bold,underline
        hi tkBrackets ctermfg=gray guifg=gray
        ]]
    elseif style == "GRUVBOX" then
        vim.cmd [[
        " for gruvbox
        hi tklink ctermfg=72 guifg=#689d6a cterm=bold,underline gui=bold,underline
        hi tkBrackets ctermfg=gray guifg=gray
        ]]
    end
end

function pkg.StyleTextHighlights(style)
    style = style or "GRUVBOX"
    style = style:upper()
    if style == "GRUVBOX" then
        vim.cmd [[
        hi tkHighlight ctermbg=214 ctermfg=124 cterm=bold guibg=#fabd2f guifg=#9d0006 gui=bold
        ]]
    elseif style == "YELLOW" then
        vim.cmd [[
        " real yellow
        hi tkHighlight ctermbg=yellow ctermfg=darkred cterm=bold guibg=yellow guifg=darkred gui=bold
        ]]
    end
end

function pkg.StyleCalendar()
    vim.cmd [[
    hi link CalNavi CalRuler
    ]]
end

function pkg.StyleTags()
    vim.cmd [[
    hi tkTagSep ctermfg=gray guifg=gray
    hi tkTag ctermfg=175 guifg=#d3869B
    ]]
end

return pkg
