local M = {}

-- 全角文字判定（UTF-8の3バイト文字：日本語など）
local function is_zenkaku(char)
    if not char then
        return false
    end
    local b = char:byte()
    return b and b >= 0xE3
end

-- 1文字ずつy/n確認（Enter不要）・UTF-8対応
local function get_yes_no(prompt)
    vim.api.nvim_echo({ { prompt .. " (y/n)", "Question" } }, true, {})
    local c = vim.fn.getchar()
    local ch = vim.fn.nr2char(c):lower()
    return ch == "y"
end

-- UTF-8文字単位で分割
local function utf8_chars(str)
    local chars = {}
    local i = 1
    local len = #str
    while i <= len do
        local c = str:byte(i)
        local charbytes = 1
        if c >= 0xF0 then
            charbytes = 4
        elseif c >= 0xE0 then
            charbytes = 3
        elseif c >= 0xC0 then
            charbytes = 2
        end
        table.insert(chars, str:sub(i, i + charbytes - 1))
        i = i + charbytes
    end
    return chars
end

local function insert_space_interactive(bufnr)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local changed = false
    local new_lines = {}

    for linenr, line in ipairs(lines) do
        local chars = utf8_chars(line)
        local new_chars = {}
        local i = 1
        while i <= #chars do
            local c1 = chars[i]
            local c2 = chars[i + 1]
            local is_c1_ascii = c1 and c1:match("^[%w%p]$")
            local is_c2_zenkaku = is_zenkaku(c2)
            local is_c1_zenkaku = is_zenkaku(c1)
            local is_c2_ascii = c2 and c2:match("^[%w%p]$")

            if is_c1_ascii and is_c2_zenkaku then
                local context = table.concat(chars, "", math.max(1, i - 5), math.min(#chars, i + 6))
                local msg = string.format(
                    "行%d: ...%s... で [%s][%s] の間にスペースを挿入？",
                    linenr,
                    context,
                    c1,
                    c2
                )
                if get_yes_no(msg) then
                    table.insert(new_chars, c1)
                    table.insert(new_chars, " ")
                    changed = true
                else
                    table.insert(new_chars, c1)
                end
            -- iはここで+1しない（c2も次で処理する）
            elseif is_c1_zenkaku and is_c2_ascii then
                local context = table.concat(chars, "", math.max(1, i - 5), math.min(#chars, i + 6))
                local msg = string.format(
                    "行%d: ...%s... で [%s][%s] の間にスペースを挿入？",
                    linenr,
                    context,
                    c1,
                    c2
                )
                if get_yes_no(msg) then
                    table.insert(new_chars, c1)
                    table.insert(new_chars, " ")
                    changed = true
                else
                    table.insert(new_chars, c1)
                end
            -- iはここで+1しない（c2も次で処理する）
            else
                table.insert(new_chars, c1)
            end
            i = i + 1
        end
        table.insert(new_lines, table.concat(new_chars))
    end

    if changed then
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
        vim.cmd("write")
        vim.notify("スペース挿入＆保存が完了しました。", vim.log.levels.INFO)
    else
        vim.notify("スペースを挿入する必要はありません。", vim.log.levels.INFO)
    end
end

-- 一括自動挿入（UTF-8対応）
local function insert_space_auto(bufnr)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local changed = false
    local new_lines = {}

    local function safe_gsub(str, pattern, repl)
        -- gsubはUTF-8でマルチバイト文字も扱える
        return str:gsub(pattern, repl)
    end

    for _, line in ipairs(lines) do
        local new_line = line
        -- ここでは全角スペース（　）とCJK漢字（例：一-龯）、ひらがな・カタカナ等も必要なら追加可能
        new_line = safe_gsub(new_line, "([%w%p])([　一-龯ぁ-んァ-ヶ])", "%1 %2")
        new_line = safe_gsub(new_line, "([　一-龯ぁ-んァ-ヶ])([%w%p])", "%1 %2")
        if new_line ~= line then
            changed = true
        end
        table.insert(new_lines, new_line)
    end

    if changed then
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
        vim.cmd("write")
        vim.notify("スペース自動挿入＆保存が完了しました。", vim.log.levels.INFO)
    else
        vim.notify("スペースを挿入する必要はありません。", vim.log.levels.INFO)
    end
end

vim.api.nvim_create_user_command("ZenkakuSpaceFix", function(opts)
    local mode = opts.fargs[1]
    if mode == "interactive" then
        insert_space_interactive(0)
    else
        insert_space_auto(0)
    end
end, {
    nargs = "?",
    complete = function()
        return { "interactive", "auto" }
    end,
    desc = "半角・全角の間にスペースを挿入して保存（interactive: 逐次確認, auto: 一括自動）",
})

return M
