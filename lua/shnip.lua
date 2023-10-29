local snippetLeader = "<c-f>"
local ftSnippetOverrides = {}
local ftSnippetKeys = {}

local function snippet(key, output, opts)
    vim.keymap.set("i", snippetLeader .. key, output, opts)
end

local function setFiletypeSnippets(snippets, overrides)
    for key, value in pairs(snippets) do
        if key == "extra" then
            for k, v in pairs(value) do
                if not overrides[k] then
                    snippet(k, v, {buffer = true})
                end
            end
        elseif ftSnippetKeys[key] then
            if overrides[key] ~= nil then
                if overrides[key] then
                    snippet(ftSnippetKeys[key],
                        overrides[key], {buffer = true})
                end
            else
                snippet(ftSnippetKeys[key], value, {buffer = true})
            end
        end
    end
    if overrides.extra then
        for key, value in pairs(overrides.extra) do
            snippet(key, value, {buffer = true})
        end
    end
end

local function addFtSnippets(filetypes, snippets)
    vim.api.nvim_create_autocmd("FileType", {
        pattern = table.concat(filetypes, ","),
        group = "FiletypeSnippets",
        callback = function()
            setFiletypeSnippets(snippets, ftSnippetOverrides[vim.o.ft] or {})
        end
    })
end

local function createFtSnippets()
    addFtSnippets({"python"}, {
        extra = {
            ["-"] = "____<left><left>"
        },
        ["print"] = 'print("")<left><left>',
        ["debug"] = "print()<left>",
        ["error"] = "print()<left>",
        ["while"] = "while :<left>",
        ["for"] = "for :<left>",
        ["if"] = "if :<esc>i",
        ["elseif"] = "elif :<left>",
        ["else"] = "else:<CR>",
        ["function"] = "def ():<esc>Bi",
        ["lambda"] = "lambda:<left>",
        ["class"] = "class :<left>",
        ["struct"] = "class :<left>",
        ["try"] = "try:<CR>...<CR>except Exception as e:<CR>...<ESC>kkA<BS><BS><BS>",
    })

    addFtSnippets({"bash", "sh"}, {
        ["print"] = 'echo<space>""<left>',
        ["debug"] = "echo<space>",
        ["error"] = "echo  >/dev/stderr<ESC>Bhi",
        ["while"] = "while ; do<CR>done<esc>k$hhhi",
        ["for"] = "for ; do<CR>done<esc>k$hhhi",
        ["if"] = "if ; then<CR>fi<esc>k$bbi",
        ["elseif"] = "elif ; then<esc>bbi",
        ["else"] = "else<CR>",
        ["switch"] = "case in<CR>esac<esc>k$bhi<space>",
        ["case"] = ")<CR>;;<esc>k$i",
        ["default"] = "*)<CR>;;<esc>O",
        ["function"] = "() {<CR>}<esc>k$F(i",
    })

    addFtSnippets({"javascript", "typescript", "typescriptreact"}, {
        ["print"] = 'console.log("");<esc>hhi',
        ["debug"] = "console.log();<esc>hi",
        ["error"] = "console.error();<esc>hi",
        ["while"] = "while () {<CR>}<esc>k$hhi",
        ["for"] = "for () {<CR>}<esc>k$hhi",
        ["if"] = "if () {<CR>}<esc>k$hhi",
        ["elseif"] = "else if () {<CR>}<esc>k$hhi",
        ["else"] = "else {<CR>}<esc>O",
        ["switch"] = "switch () {<CR>}<esc>k$hhi",
        ["case"] = 'case tmp:<CR>break;<esc>k$B"_cw',
        ["default"] = "default:<CR>break;<esc>O",
        ["function"] = "function () {<CR>}<esc>k$F(i",
        ["lambda"] = "() => {<CR>}<esc>%F)i",
        ["class"] = "class  {<CR>}<esc>k$hi",
        ["struct"] = "interface  {<CR>}<esc>k$hi",
        ["try"] = "try {<CR>}<CR>catch (error) {<CR>}<ESC>kkO",
    })

    addFtSnippets({"c"}, {
        ["print"] = 'printf("\\n");<esc>hhhhi',
        ["debug"] = "printf();<esc>hi",
        ["while"] = "while () {<CR>}<esc>k$hhi",
        ["for"] = "for () {<CR>}<esc>k$hhi",
        ["if"] = "if () {<CR>}<esc>k$hhi",
        ["elseif"] = "else if () {<CR>}<esc>k$hhi",
        ["else"] = "else {<CR>}<esc>O",
        ["switch"] = "switch () {<CR>}<esc>k$hhi",
        ["case"] = 'case tmp:<CR>break;<esc>k$B"_cw',
        ["default"] = "default:<CR>break;<esc>O",
        ["function"] = "() {<CR>}<esc>k$F(i",
        ["struct"] = "struct  {<CR>}<esc>k$hi",
        ["try"] = "try {<CR>}<CR>catch {<CR>}<ESC>kkO",
    })

    addFtSnippets({"cpp"}, {
        ["print"] = 'printf("\\n");<esc>hhhhi',
        ["debug"] = "printf();<esc>hi",
        ["while"] = "while () {<CR>}<esc>k$hhi",
        ["for"] = "for () {<CR>}<esc>k$hhi",
        ["if"] = "if () {<CR>}<esc>k$hhi",
        ["elseif"] = "else if () {<CR>}<esc>k$hhi",
        ["else"] = "else {<CR>}<esc>O",
        ["switch"] = "switch () {<CR>}<esc>k$hhi",
        ["case"] = 'case tmp:<CR>break;<esc>k$B"_cw',
        ["default"] = "default:<CR>break;<esc>O",
        ["function"] = "() {<CR>}<esc>k$F(i",
        ["lambda"] = "[]() {}<left><left><left><left>",
        ["class"] = "class  {<CR>}<esc>k$hi",
        ["struct"] = "struct  {<CR>}<esc>k$hi",
        ["try"] = "try {<CR>}<CR>catch {<CR>}<ESC>kkO",
    })

    addFtSnippets({"java"}, {
        ["print"] = 'system.out.println("");<esc>hhi',
        ["debug"] = "system.out.println();<esc>hi",
        ["while"] = "while () {<CR>}<esc>k$hhi",
        ["for"] = "for () {<CR>}<esc>k$hhi",
        ["if"] = "if () {<CR>}<esc>k$hhi",
        ["elseif"] = "else if () {<CR>}<esc>k$hhi",
        ["else"] = "else {<CR>}<esc>O",
        ["switch"] = "switch () {<CR>}<esc>k$hhi",
        ["case"] = 'case tmp:<CR>break;<esc>k$B"_cw',
        ["default"] = "default:<CR>break;<esc>O",
        ["function"] = "() {<CR>}<esc>k$F(i",
        ["lambda"] = "() -> {}<esc>F)i",
        ["class"] = "public class  {<CR>}<esc>k$hi",
        ["struct"] = "private class  {<CR>}<esc>k$hi",
        ["try"] = "try {<CR>}<CR>catch {<CR>}<ESC>kkO",
    })

    addFtSnippets({"cs"}, {
        ["print"] = 'Debug.Log("");<esc>hhi',
        ["debug"] = "Util.Log();<left><left>",
        ["while"] = "while () {<CR>}<esc>k$hhi",
        ["for"] = "for () {<CR>}<esc>k$hhi",
        ["if"] = "if () {<CR>}<esc>k$hhi",
        ["elseif"] = "else if () {<CR>}<esc>k$hhi",
        ["else"] = "else {<CR>}<esc>O",
        ["switch"] = "switch () {<CR>}<esc>k$hhi",
        ["case"] = 'case tmp:<CR>break;<esc>k$B"_cw',
        ["default"] = "default:<CR>break;<esc>O",
        ["function"] = "() {<CR>}<esc>k$F(i",
        ["lambda"] = "[]() {}<left><left><left><left>",
        ["class"] = "class  {<CR>}<esc>k$hi",
        ["struct"] = "struct  {<CR>}<esc>k$hi",
        ["try"] = "try {<CR>}<CR>catch {<CR>}<ESC>kkO",
    })

    addFtSnippets({"lua"}, {
        ["print"] = 'print("")<left><left>',
        ["debug"] = "vim.print()<left>",
        ["while"] = "while true do<CR>end<esc>k$BB\"_ciw",
        ["for"] = "for do<CR>end<esc>k$Bhi ",
        ["if"] = "if true then<CR>end<esc>k$BB\"_ciw",
        ["elseif"] = "elseif true then<esc>BB\"_ciw",
        ["else"] = "else<CR>",
        ["function"] = "local function name()<CR>end<esc>k$F(\"_cb",
        ["lambda"] = "function()<CR>end<esc>O",
        ["try"] = "pcall(function()<CR>end)<esc>O",
    })

    addFtSnippets({"rust"}, {
        ["print"] = 'println!("");<esc>$F"i',
        ["debug"] = "dbg!(&);<esc>hi",
        ["while"] = "while  {<CR>}<esc>k$hi",
        ["for"] = "for  {<CR>}<esc>k$hi",
        ["if"] = "if  {<CR>}<esc>k$hi",
        ["elseif"] = "else if  {<CR>}<esc>k$hi",
        ["else"] = "else {<CR>}<esc>O",
        ["switch"] = "match  {<CR>}<esc>k$hi",
        ["enum"] = "enum  {<CR>}<esc>k$hi",
        ["struct"] = "struct  {<CR>}<esc>k$hi",
        ["function"] = "fn () {<CR>}<esc>k$F(i",
    })

    addFtSnippets({"go"}, {
        ["print"] = 'fmt.Println("")<esc>hi',
        ["debug"] = "fmt.Println()<esc>i",
        ["while"] = "for  {<CR>}<esc>k$hi",
        ["for"] = "for  {<CR>}<esc>k$hi",
        ["if"] = "if  {<CR>}<esc>k$hi",
        ["elseif"] = "else if  {<CR>}<esc>k$hi",
        ["else"] = "else {<CR>}<esc>O",
        ["switch"] = "switch  {<CR>}<esc>k$hi",
        ["case"] = "case :<CR>fallthrough<esc>k$i",
        ["default"] = "default:<esc>O",
        ["function"] = "func () {<CR>}<esc>k$F(i",
        ["struct"] = "type  struct {<CR>}<esc>k$bhi",
    })
end

-- example config:
-- local overrides = {
--     python = {                           -- filetype
--         extra = {
--             ["<c-a>"] = "test"           -- add new snippet
--         },
--         print = false,                   -- disable a snippet
--         class = "class{<cr>}<esc>kgli",  -- modify a snippet
--     },
-- }
-- local keys = {
--    ["print"]    = "<down>",
--    ["debug"]    = "<c-d>",
--    ["error"]    = "<c-x>",
--    ["while"]    = "<c-w>",
--    ["for"]      = "<c-f>",
--    ["if"]       = "<c-i>",
--    ["elseif"]   = "<c-o>",
--    ["else"]     = "<c-e>",
--    ["switch"]   = "<c-s>",
--    ["case"]     = "<c-v>",
--    ["default"]  = "<c-b>",
--    ["function"] = "<c-m>",
--    ["lambda"]   = "<c-l>",
--    ["class"]    = "<c-k>",
--    ["struct"]   = "<c-h>",
--    ["try"]      = "<c-t>",
--    ["enum"]     = "<c-n>"
-- }
-- require("snippets").setup({
--     overrides = overrides,
--     leader = "<c-f>",
--     keys = keys,
-- })

local function setup(opts)
    opts = opts or {}
    ftSnippetOverrides = opts.overrides or {}
    snippetLeader = opts.leader or snippetLeader
    ftSnippetKeys = opts.keys or {}
    vim.api.nvim_create_augroup("FiletypeSnippets", { clear = true })
    createFtSnippets()
end

return {
    setup = setup,
    addFtSnippets = addFtSnippets,
    snippet = snippet,
}
