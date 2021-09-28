# null-ls.nvim

Use Neovim as a language server to inject LSP diagnostics, code actions, and
more via Lua.

## Motivation

Neovim's LSP ecosystem is growing, and plugins like
[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) and
[trouble.nvim](https://github.com/folke/trouble.nvim) make it a joy to work with
LSP features like code actions and diagnostics.

Unlike the VS Code and coc.nvim ecosystems, Neovim doesn't provide a way for
non-LSP sources to hook into its LSP client. null-ls is an attempt to bridge
that gap and simplify the process of creating, sharing, and setting up LSP
sources using pure Lua.

null-ls is also an attempt to reduce the boilerplate required to set up
general-purpose language servers and improve performance by removing the need
for external processes.

## Status

null-ls is in **beta status**. Please open an issue if something doesn't
work the way you expect (or doesn't work at all).

At the moment, null-is is compatible with Neovim 0.5 (stable) and 0.6 (head),
but you'll get the best experience from the latest version you can run.

Note that null-ls is built on macOS and Linux and may not work as expected (or
at all) on Windows. Contributions to expand Windows support are welcome, but
since I don't work on Windows, my ability to diagnose or fix Windows issues is
nonexistent.

## Features

null-ls sources are able to hook into the following LSP features:

- Code actions

- Diagnostics

- Formatting (including range formatting)

null-ls includes built-in sources for each of these features to provide
out-of-the-box functionality. See [BUILTINS](doc/BUILTINS.md) for instructions on
how to set up sources and a list of available sources.

null-ls also provides helpers to streamline the process of spawning and
transforming the output of command-line processes into an LSP-friendly format.
If you want to create your own source, either for personal use or for a plugin,
see [HELPERS](doc/HELPERS.md) for details.

## Setup

Install null-ls using your favorite package manager. The plugin depends on
[plenary.nvim](https://github.com/nvim-lua/plenary.nvim) and
[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig), both of which you
are (probably) already using.

Please see [CONFIG](doc/CONFIG.md) for information about setting up and
configuring null-ls.

At a minimum, you must register at least one source and set up the plugin's
integration with nvim-lspconfig, as in this example:

```lua
-- example configuration! (see CONFIG above to make your own)
require("null-ls").config({
    sources = { require("null-ls").builtins.formatting.stylua }
})
require("lspconfig")["null-ls"].setup({
    on_attach = my_custom_on_attach
})

```

## Documentation

The definitive source for information about null-ls is its
[documentation](doc/MAIN.md), which contains information about how null-ls
works, how to set it up, and how to create sources.

## Contributing

Contributions to add new features and built-ins for any language are always
welcome. See [CONTRIBUTING](doc/CONTRIBUTING.md) for guidelines.

## Examples

### Parsing buffer content

The following example demonstrates a diagnostic source that will parse the
current buffer's content and show instances of the word `really` as LSP
warnings.

```lua
local null_ls = require("null-ls")
local api = vim.api

local no_really = {
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = { "markdown", "txt" },
    generator = {
        fn = function(params)
            local diagnostics = {}
            -- sources have access to a params object
            -- containing info about the current file and editor state
            for i, line in ipairs(params.content) do
                local col, end_col = line:find("really")
                if col and end_col then
                    -- null-ls fills in undefined positions
                    -- and converts source diagnostics into the required format
                    table.insert(diagnostics, {
                        row = i,
                        col = col,
                        end_col = end_col,
                        source = "no-really",
                        message = "Don't use 'really!'",
                        severity = 2,
                    })
                end
            end
            return diagnostics
        end,
    },
}

null_ls.register(no_really)
```

### Parsing CLI program output

null-ls includes helpers to simplify the process of spawning and capturing the
output of CLI programs. This example shows how to pass the content of the
current buffer to `markdownlint` via `stdin` and convert its output (which it
sends to `stderr`) into LSP diagnostics:

```lua
local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

local markdownlint = {
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = { "markdown" },
    -- null_ls.generator creates an async source
    -- that spawns the command with the given arguments and options
    generator = null_ls.generator({
        command = "markdownlint",
        args = { "--stdin" },
        to_stdin = true,
        from_stderr = true,
        -- choose an output format (raw, json, or line)
        format = "line",
        check_exit_code = function(code)
            return code <= 1
        end,
        -- use helpers to parse the output from string matchers,
        -- or parse it manually with a function
        on_output = helpers.diagnostics.from_patterns({
            {
                pattern = [[:(%d+):(%d+) [%w-/]+ (.*)]],
                groups = { "row", "col", "message" },
            },
            {
                pattern = [[:(%d+) [%w-/]+ (.*)]],
                groups = { "row", "message" },
            },
        }),
    }),
}

null_ls.register(markdownlint)
```

### Advanced usage

This [ESLint
integration](https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils/blob/main/lua/nvim-lsp-ts-utils/null-ls.lua)
from one of my plugins demonstrates an advanced example of parsing JSON output
from a command to generate code actions.

## FAQ

### How do I set the path to neovim binary?

Set it while calling lsp setup for null-ls.
```lua
require("lspconfig")["null-ls"].setup({ cmd = { "/path/to/nvim" }, ... })
```

### How do I format files?

null-ls formatters run when you call `vim.lsp.buf.formatting()` or
`vim.lsp.buf.formatting_sync()`. If a source supports it, you can run range
formatting by visually selecting part of the buffer and calling
`vim.lsp.buf.range_formatting()`.

### How do I stop Neovim from asking me which server I want to use for formatting?

See [this wiki page](https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts).

### How do I format files on save?

See the following snippet:

```lua
-- add to a specific server's on_attach,
-- or to a common on_attach callback to enable for all supported filetypes
on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
end
```

### Does it work with (other plugin)?

In most cases, yes. null-ls tries to act like an actual LSP server as much as
possible, so it should work seamlessly with most LSP-related plugins. If you run
into problems, please try to determine which plugin is causing them and open an
issue.

[This wiki
page](https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Compatibility-with-other-plugins)
mentions plugins that require specific configuration options / tweaks to work
with null-ls.

### How does it work?

Thanks to hard work by @folke, the plugin wraps the mechanism Neovim uses to
spawn language servers to start a client entirely in-memory. The client attaches
to buffers that match defined sources and receives and responds to requests,
document changes, and other events from Neovim.

### Will it affect my performance?

More testing is necessary, but since null-ls uses pure Lua and runs entirely in
memory without any external processes, in most cases it should run faster than
similar solutions. If you notice that performance is worse with null-ls than
with an alternative, please open an issue!

### How to enable and use debug mode

1. Set `debug` flag to `true` in the config like so:

   ```lua
   require("null-ls").config({
       debug = true
   })
   ```

2. Use `:NullLsInfo` to get the path to your debug log.

As with LSP logging, `debug` will slow down Neovim. Make sure to disable the
option after you've collected the information you're looking for.

## Tests

The test suite includes unit and integration tests and depends on plenary.nvim.
Run `make test` in the root of the project to run the suite or
`FILE=filename_spec.lua make test-file` to test an individual file.

## Alternatives

- [efm-langserver](https://github.com/mattn/efm-langserver) and
  [diagnostic-languageserver](https://github.com/iamcco/diagnostic-languageserver):
  general-purpose language servers that can provide formatting and diagnostics
  (but not code actions) from CLI output. Both require installing external
  executables, and neither provides built-ins (and configuring them is, to put
  it nicely, unfriendly).

- [nvim-lint](https://github.com/mfussenegger/nvim-lint): a Lua plugin that
  focuses on providing diagnostics from CLI output. Provides built-in linters.
  Runs independently, which provides flexibility but requires users to define
  their own autocommands. Does not currently support writing to temp files for
  diagnostics.

- [formatter.nvim](https://github.com/mhartington/formatter.nvim): a Lua plugin
  that (surprise) focuses on formatting. Does not currently provide built-in
  formatters, meaning users have to define their own. Makes no attempt to
  integrate with LSP behavior (which may be an upside or a downside).
