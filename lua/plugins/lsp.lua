--[[

LSP: Language Server Protocal

Open JSON RPC Standard - to standardize communication between TextEditors and language servers running on your computer.

Language Server: This software running on your machine springs into action when you write a code by giving you, 
    - error highlighting
    - auto-completion
    - go to definition
    - see description of a function/class
    - etc other cool features that make your debugging & code manuevring easy


Language server & editor communicate with each via JSONs, in editors like VSCode this is handled internally,
but in neovim its hands on.

How is it hands on?
    1. DIY download neovim
    2. DIY download a language server (tsserver, lua_ls, pyright)
    3. DIY a plugin to communicate with language server (nvim-lsp)
    4. configure nvim-lsp to communicate with language server


2. mason
Mason plugin is a LSP Manager, it helps us to download, update, track, maintain LSPs for our use
> you can DIY but mason does it better

3. mason-lspconfig
Briges the communication between lspconfig & mason


# Commands:
:Mason - open mason homepage
:LspInfo - LSPs that is/are connected to our current-buffer
:help vim.lsp.buf - all buffer callback that can be mapped


--]]--

return {
    -- Mason: LSP server manager (installs & manages the LSPs for us)
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },

    -- Mason LSP config bridge between LSPs & Neovim
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({ 
                ensure_installed = { "pyright", "lua_ls" }
            })
        end
    },

    -- Core LSP config (processes & updates the buffer based on the response received from LSP via mason-lspconfig)
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local lspconfig = require("lspconfig")
            local util = require("lspconfig.util")

            -- lua_ls config
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                    },
                },
                root_dir = util.root_pattern(".luarc.json", ".git", "init.lua"),
                single_file_support = false -- prevent lsp-attachment outside root
            })

            -- pyright config (default is often fine)
            lspconfig.pyright.setup({
                capabilities = capabilities
            })

            -- basic keymaps
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP: Hover" })
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Go to definition" })
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code action" })
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename symbol" })
            vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP: Find references" })
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "LSP: Next diagnostic" })
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "LSP: Prev diagnostic" })
        end
    },
}

