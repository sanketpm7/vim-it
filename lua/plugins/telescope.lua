return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            { "nvim-telescope/telescope-project.nvim" },
            { "nvim-telescope/telescope-ui-select.nvim" },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    layout_strategy = "vertical",
                    layout_config = {
                        prompt_position = "top",
                        width = 0.95,
                        height = 0.85,
                    },
                    dynamic_preview_title = true,
                    sorting_strategy = "ascending",
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close,
                            ["<S-j>"] = actions.move_selection_next,
                            ["<S-k>"] = actions.move_selection_previous,
                        },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                    project = {
                        base_dirs = { "~" },
                        hidden_files = true,
                    },
                }
            })

            telescope.load_extension("fzf")
            telescope.load_extension("project")
            telescope.load_extension("ui-select")

            local builtin = require("telescope.builtin")
            local map = vim.keymap.set


            map("n", "<leader>ff", builtin.find_files, { desc = "Telescope: Find files in current working directory" })
            map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope: Live grep search across files" })
            map("n", "<leader>fb", builtin.buffers, { desc = "Telescope: List open buffers" })
            map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope: Search Neovim help tags" })
            map("n", "<leader>fr", builtin.oldfiles, { desc = "Telescope: List recently opened files" })
            map("n", "<leader>km", builtin.keymaps, { desc = "Telescope: List all keymappings" })
            map("n", "<leader>gs", builtin.git_status, { desc = "Telescope: Show git status files" })

            map("n", "<leader>fc", function()
                builtin.find_files({ prompt_title = "< Neovim Config >", cwd = "~/.config/nvim" })
            end, { desc = "Telescope: Find Neovim configuration files" })

            map("n", "<leader>fp", function()
                telescope.extensions.project.project()
            end, { desc = "Telescope: List and switch between projects" })

            map("n", "<leader>u",function()
                telescope.extensions["ui-select"].ui_select()
            end, { desc = "Telescope: Show LSP code actions" })
        end
    },
}

