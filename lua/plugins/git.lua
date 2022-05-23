--- Git-related plugins
return {
  -- Git support for nvim.
  {
    'tpope/vim-fugitive',
    as = "fugitive",
    cmd = 'Git'
  },

  -- Shows hidden "git messages" for each line
  {
    "rhysd/git-messenger.vim",
    as = "git-messenger",
    cmd = "GitMessenger",
  },

  -- Git signs.
  {
    'lewis6991/gitsigns.nvim',
    as = "gitsigns",
    requires = {
      'nvim-lua/plenary.nvim'
    },
    event = 'BufRead',
    config = function()
        require('config.gitsigns').setup()
    end
  },

  {
        "https://github.com/whiteinge/diffconflicts",
        as = "diffconflicts",
        cmd = "DiffConflicts"
  },

  -- Tig explorer.
  {
    'iberianpig/tig-explorer.vim',
    as = "tig",
    cmd = "tig",
    requires = 'bclose',
    config = function()
        -- From https://github.com/mhinz/neovim-remote
        -- Auto-deletes git-related buffers when closed so that nvr knows we're done with them
        vim.cmd([[autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete]])
    end
  },
}
