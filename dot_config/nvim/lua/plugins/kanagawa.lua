return {
    'rebelot/kanagawa.nvim',
    enabled = false,
    event = "VimEnter",
    config = function()
        vim.cmd.colorscheme "kanagawa"
    end,
}
