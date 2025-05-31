return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                theme = "catppuccin", -- Match your color scheme
                section_separators = "",
                component_separators = ""
            }
        })
    end
}
