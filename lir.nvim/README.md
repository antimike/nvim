# lir.nvim

A simple file explorer

Note: lir.nvim does not define any default mappings, you need to configure them yourself by referring to [help](doc/lir.txt).


## Installation

```vim
Plug 'tamago324/lir.nvim'
Plug 'nvim-lua/plenary.nvim'

" Optional
Plug 'kyazdani42/nvim-web-devicons'
```


## Configuration

```lua
local actions = require'lir.actions'
local mark_actions = require 'lir.mark.actions'
local clipboard_actions = require'lir.clipboard.actions'

require'lir'.setup {
  show_hidden_files = false,
  devicons_enable = true,
  mappings = {
    ['l']     = actions.edit,
    ['<C-s>'] = actions.split,
    ['<C-v>'] = actions.vsplit,
    ['<C-t>'] = actions.tabedit,

    ['h']     = actions.up,
    ['q']     = actions.quit,

    ['K']     = actions.mkdir,
    ['N']     = actions.newfile,
    ['R']     = actions.rename,
    ['@']     = actions.cd,
    ['Y']     = actions.yank_path,
    ['.']     = actions.toggle_show_hidden,
    ['D']     = actions.delete,

    ['J'] = function()
      mark_actions.toggle_mark()
      vim.cmd('normal! j')
    end,
    ['C'] = clipboard_actions.copy,
    ['X'] = clipboard_actions.cut,
    ['P'] = clipboard_actions.paste,
  },
  float = {
    winblend = 0,

    -- -- You can define a function that returns a table to be passed as the third
    -- -- argument of nvim_open_win().
    -- win_opts = function()
    --   local width = math.floor(vim.o.columns * 0.8)
    --   local height = math.floor(vim.o.lines * 0.8)
    --   return {
    --     border = require("lir.float.helper").make_border_opts({
    --       "+", "─", "+", "│", "+", "─", "+", "│",
    --     }, "Normal"),
    --     width = width,
    --     height = height,
    --     row = 1,
    --     col = math.floor((vim.o.columns - width) / 2),
    --   }
    -- end,
  },
  hide_cursor = true,
}

-- custom folder icon
require'nvim-web-devicons'.set_icon({
  lir_folder_icon = {
    icon = "",
    color = "#7ebae4",
    name = "LirFolderNode"
  }
})

-- use visual mode
function _G.LirSettings()
  vim.api.nvim_buf_set_keymap(0, 'x', 'J', ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>', {noremap = true, silent = true})

  -- echo cwd
  vim.api.nvim_echo({{vim.fn.expand('%:p'), 'Normal'}}, false, {})
end

vim.cmd [[augroup lir-settings]]
vim.cmd [[  autocmd!]]
vim.cmd [[  autocmd Filetype lir :lua LirSettings()]]
vim.cmd [[augroup END]]
```

NOTE: Actions can be added easily (see [wiki](https://github.com/tamago324/lir.nvim/wiki/Custom-actions))

## Usage

### Use normal buffer (like dirvish)

```sh
$ nvim /path/to/directory/
```

or

```vim
:edit .
```

### Use floating window

```
:lua require'lir.float'.toggle()
:lua require'lir.float'.init()
```

Change highlights groups.

```viml
hi LirFloatNormal guibg=#32302f
hi LirDir guifg=#7ebae4
hi LirSymLink guifg=#7c6f64
hi LirEmptyDirText guifg=#7c6f64
```


### Extensions

* [tamago324/lir-mmv.nvim](https://github.com/tamago324/lir-mmv.nvim)
* [tamago324/lir-bookmark.nvim](https://github.com/tamago324/lir-bookmark.nvim)
* [tamago324/lir-git-status.nvim](https://github.com/tamago324/lir-git-status.nvim)


## Credit

* [mattn/vim-molder](https://github.com/mattn/vim-molder)
* [norcalli/nvim_utils](https://github.com/norcalli/nvim_utils)
* [lambdalisue/fern.vim](https://github.com/lambdalisue/fern.vim)

## Screenshots

![](https://github.com/tamago324/images/blob/master/lir.nvim/lir-normal.png)

![](https://github.com/tamago324/images/blob/master/lir.nvim/lir-float.png)


## License

MIT
