--[[
Auto complete is a bit tricky & there is no set standard. Relies on a variety of
plugins developed by the community

working:
- Completion engine
- Source
- Snipper engine

Completion engine is a plugin that reads the file as you go & suggest you a list of completion values,
these list of completion values are "sourced" from different directories, sources etc
- nvim-cmp


--]]

return {
    {
        'hrsh7th/cmp-nvim-lsp',
    },
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets'
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    -- completion engine - setup the completion engine config + snippet-engine that nvim uses
    -- I've configured the completion engine to use `luasnip` snippet engine
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        luasnip.lsp_expand(args.body)

                        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

                        -- For `mini.snippets` users:
                        -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
                        -- insert({ body = args.body }) -- Insert at cursor
                        -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
                        -- require("cmp.config").set_onetime({ sources = {} })
                    end,
                },
                -- how the completion dropdown window looks
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },

                -- keybindings for scrolling through docs & dropdowns
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

                    -- Vim-style completion navigation
                        -- ['<C-j>'] = cmp.mapping.select_next_item(),
                        -- ['<C-k>'] = cmp.mapping.select_prev_item(),


                    -- go to next suggestion
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif require("luasnip").expand_or_jumpable() then
                            require("luasnip").expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    -- go to previous suggestion
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif require("luasnip").jumpable(-1) then
                            require("luasnip").jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" })}),

                sources = cmp.config.sources(
                    {
                        { name = 'nvim_lsp' }, -- LSP
                        { name = 'luasnip' }, -- For luasnip users.
                        -- { name = 'vsnip' }, -- For vsnip users.
                        -- { name = 'ultisnips' }, -- For ultisnips users.
                        -- { name = 'snippy' }, -- For snippy users.
                    },
                    {
                        { name = 'buffer' },
                    }
                )
            })
        end

    }
}
