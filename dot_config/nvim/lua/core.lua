-- 表示
-- -番号表示
vim.opt.number = true
-- -特殊文字表示
vim.opt.list = true
vim.opt.listchars = { tab = ">-", trail = "*", nbsp = "+" }
-- -エラー時の音を画面表示に
vim.opt.visualbell = true
-- -括弧の連携
vim.opt.showmatch = true
vim.opt.matchtime = 1
-- -ヘルプファイル
vim.opt.helplang = "ja", "en"
-- -tabバーの表示
vim.opt.showtabline = 2

-- 入力時
-- -インデントをC言語風に
vim.opt.smartindent = true
-- -タブ文字
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- 検索
-- -大文字無視
vim.opt.ignorecase = true
-- -大文字で検索したら区別をつける
vim.opt.smartcase = true
-- -検索が末尾までいったら先頭から検索
vim.opt.wrapscan = true

-- カーソル移動
-- 削除時の対象
vim.opt.backspace = 'start', 'eol', 'indent'

-- ファイル環境
-- -フォーマット
vim.opt.fileformats =  "unix", "mac", "dos"

-- クリップボード連携
--vim.opt.clipboard:append({unnamedeplus = true})
vim.opt.clipboard = "unnamedplus"

-- マウス有効
vim.opt.mouse = "a"

-- leader key 変更
vim.g.mapleader = " "

-- 空白のハイライト
vim.api.nvim_create_augroup("extra-whitespace", {})
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter" }, {
    group = "extra-whitespace",
    pattern = { "*" },
    command = [[call matchadd('ExtraWhitespace', '[\u200B\u3000]')]],
})
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    group = "extra-whitespace",
    pattern = { "*" },
    command = [[highlight default ExtraWhitespace ctermbg=202 ctermfg=202 guibg=salmon]],
})
