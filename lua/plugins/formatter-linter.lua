--[[

Formatter & Linter are CLI Tools.

What are CLI Tools, they're programs that you can access via command line,
you pass-in(input) you file(foo.py) and they run certain processing on them & give
a response back.

Formatting: changing the indentation, commas, spaces between vars, sorting imports
            etc other stuff that makes your code look clean & neat
Linter: parses your code & give you a list of possible errors, bugs, non-standard complaint code
        in you file and asks you to fix them.

Neovim is a pure text editor, we use nvim-lsp to plugin & attach it to neovim, this empowers our nvim
to communicate the LSPs installed in our system.

(Neovim + nvim-lsp) <-> LSP (Pyright, lua-language-server,...)

These CLI tools are not LSP hence they connect interact with Neovim & perform action on the buffers,
so the formatter & linter plugin are a generic-lsp that manage the CLI tools & allows
nvim-lsp to interact with the cli-tools.

(nvim-lsp) <-> (plugin - cli-tools)

e.g.: null-ls (deprecated did exactly this)

Before you setup the plugin, you need to download the necessary formatter or linters locally,
(a): explicitly download & intall them
(b): use :Mason to do so

LINTING:
1. nvim-lint
- this plugin checks the system path for the linter you've asked it to use or goes to the mason
    path to check if the configured linter exits

--]]

return {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufReadPost", "InsertLeave" }, -- trigger linting on write/read/leave insert
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            python = { "flake8" },
            lua = { "luacheck" },
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            sh = { "shellcheck" },
        }

        -- Auto lint on save
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end
}

-- you can use `conform` and install required formatter using Mason
-- setup up events & autocmd to format file on command
-- else, LSP to handles formatting for you, you just need to visual-select the text and user `=`



