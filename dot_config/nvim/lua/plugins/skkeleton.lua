return {
    "vim-skk/skkeleton",
    dependencies = {
        "vim-denops/denops.vim",
        "Shougo/ddc.vim",
        -- "Shougo/pum.vim",
        -- "Shougo/ddc-ui-pum",
        "Shougo/ddc-ui-native",
        "delphinus/skkeleton_indicator.nvim",
    },
    config = function()
        vim.fn["skkeleton#config"]({
            globalDictionaries = { "~/.config/skk/SKK-JISYO.L" },
            eggLikeNewline = true,
        })
        vim.fn["ddc#custom#patch_global"]("ui", "native")
        vim.fn["ddc#custom#patch_global"]("sources", { "skkeleton" })
        vim.fn["ddc#custom#patch_global"]({
            sourceOptions = {
                ["skkeleton"] = {
                    mark = "skkeleton",
                    matchers = {},
                    sorters = {},
                    converters = {},
                    isVolatile = true,
                    minAutoCompleteLength = 1,
                },
            },
        })
        vim.fn["ddc#enable"]()
    end,
}
