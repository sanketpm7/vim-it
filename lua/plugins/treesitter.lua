-- Treesitter (highlight, indent)
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    lazy = false,
    config = function()
        local ts_configs = require("nvim-treesitter.configs")
        ts_configs.setup({
            -- install parsers for the below languages for treesitter - 
            -- uses language specific parser at runtime to generate highlight & other functionality
            ensure_installed = {
                "lua", "python", "bash", "html", "css", "json", "javascript", "typescript", "vim", "markdown", "markdown_inline"
            },
            -- auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                  init_selection = "<leader>ss", -- set to `false` to disable one of the mappings
                  node_incremental = "<leader>si",
                  node_decremental = "<leader>sd",
                  scope_incremental = "<leader>sc"
                },
            },
            textobjects = {
              select = {
                enable = true,
                lookahead = true,
                keymaps = {
                  ["af"] = "@function.outer",
                  ["if"] = "@function.inner",
                  ["ac"] = "@class.outer",
                  ["ic"] = "@class.inner",
                },
              },
            }

        })
    end
}
