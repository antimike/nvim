local present, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
if not present then
    return
end

nvim_treesitter.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  matchup = {
    enable = true,
  },
  indent = {
    enable = true
  },
  autotag = {
    enable = true
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
    persist_queries = false
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
    }
  },
  context_commentstring = {
    enable = true,
    -- For integration with kommentary.nvim
    enable_autocmd = false,
    config = {
      -- Included for illustrative purposes
      -- See nvim-ts-context-commentstring docs for more info
      css = '// %s',
      javascript = {
        __default = '// %s',
        jsx_element = '{/* %s */}',
        jsx_fragment = '{/* %s */}',
        jsx_attribute = '// %s',
        comment = '// %s'
      },
      typescript = {
        __default = '// %s',
        __multiline = '/* %s */'
      }
    }
  },
  textobjects = {
    select = {
      enable = true,
      -- Autojump to textobj (like targets.vim)
      lookahead = true,
      keymaps = {
        -- cf. textobjects.scm
        ['af'] = "@function.outer",
        ['if'] = "@function.inner",
        ['ac'] = "@class.outer",
        ['ic'] = "@class.inner",
      }
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']m'] = "@function.outer",
        [']]'] = "@class.outer",
      },
      goto_next_end = {
        [']M'] = "@function.outer",
        [']['] = "@class.outer",
      },
      goto_previous_start = {
        ['[m'] = "@function.outer",
        ['[['] = "@class.outer",
      },
      goto_previous_end = {
        ['[M'] = "@function.outer",
        ['[]'] = "@class.outer",
      }
    },
    swap = {
      enable = true,
      swap_next = {["<Leader>xp"] = "@parameter.inner"},
      swap_previous = {["<Leader>xP"] = "@parameter.inner"}
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      peek_definition_code = {
        ["<Leader>pf"] = "@function.outer",
        ["<Leader>pc"] = "@class.outer",
      }
    }
  }
}

vim.cmd
[[
  autocmd BufEnter * set foldmethod=expr
  autocmd BufEnter * set foldexpr=nvim_treesitter#foldexpr()
  set foldlevel=99
]]
