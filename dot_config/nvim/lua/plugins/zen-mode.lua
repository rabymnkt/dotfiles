return {
    "folke/zen-mode.nvim",
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        window = {
            backdrop = 0.95,
            width = 100,
        },
        plugins = {
            wezterm = {
                enable = true,
                font = "+4"
            },
        }
    }
}
