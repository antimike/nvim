-- Defining alias for vim.opt.
local opt = vim.opt
local exec = vim.api.nvim_exec

local NoWhitespace = exec(
	[[
    function! NoWhitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfunction
    call NoWhitespace()
    ]],
	true
)

-- Decrease time of completion menu.
opt.updatetime = 300
vim.g.cursorhold_updatetime = 100

-- Number settings.
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true

-- Set signcolumn width to 2
vim.opt.signcolumn = "yes:3"

-- Remove showing mode.
opt.showmode = false

-- True collor support.
opt.termguicolors = true

-- Enable clipboard.
opt.clipboard = "unnamedplus"

-- Enable mouse in all modes.
opt.mouse = "a"

-- Enable cursor line.
opt.cursorline = true

-- Setting colorcolumn. This is set because of
-- this (https://github.com/lukas-reineke/indent-blankline.nvim/issues/59)
-- indent-blankline bug.
opt.colorcolumn = "9999"

-- With set hidden you’re telling Neovim that you can
-- have unsaved worked that’s not displayed on your screen.
opt.hidden = true

-- Set indentation stuf.
opt.tabstop = 8
-- opt.shiftwidth = 4
opt.smartindent = true
opt.smartcase = true
opt.expandtab = true
opt.pumheight = 25 -- pop up menu height

-- Set searching stuf.
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true

-- Set terminal bidirectual.
-- For writing in right to left languages like arabic, persian and hebrew.
opt.termbidi = true

-- Without this option some times backspace did not work correctly.
opt.backspace = "indent,eol,start"

-- For opening splits on right or bottom.
opt.splitbelow = true
opt.splitright = true

-- Enabling ruler and statusline.
opt.ruler = true

-- Setting time that Neovim wait after each keystroke.
opt.timeoutlen = 200

-- Setting up autocomplete menu.
opt.completeopt = "menu,menuone,noselect,preview,noinsert,noselect"

-- Set line number for help files.
vim.cmd([[
augroup help_config
  autocmd!
  autocmd FileType help :set number
augroup END
]])

-- Trim Whitespace
exec([[au BufWritePre * call NoWhitespace()]], false)

-- Auto open nvim-tree when writing (nvim .) in command line
-- and auto open Dashboard when nothing given as argument.
vim.cmd([[
if index(argv(), ".") >= 0
  autocmd VimEnter * NvimTreeOpen
  bd1
elseif len(argv()) == 0
  autocmd VimEnter * Dashboard
endif
]])

vim.cmd("command CodeArtTransparent lua make_codeart_transparent()")

-- Persistent undo
opt.undofile = true

-- Add cursorline and diasable it in some buffers and filetypes.
statusline_hide = {
	"dashboard",
	"TelescopePrompt",
	"TelescopeResults",
	"terminal",
	"toggleterm",
}

function hide_statusline(types)
	for _, type in pairs(types) do
		if vim.bo.filetype == type or vim.bo.buftype == type then
			opt.laststatus = 0
			opt.ruler = false
			opt.cursorline = false
			break
		else
			opt.laststatus = 2
			opt.ruler = true
			opt.cursorline = true
		end
	end
end

-- BufEnter,BufRead,BufWinEnter,FileType,WinEnter
vim.cmd("autocmd BufEnter,BufRead,BufWinEnter,FileType,WinEnter * lua hide_statusline(statusline_hide)")
