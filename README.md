# shnip
shit snippets

### example config
```lua
require("shnip").setup({
    leader = "<c-f>",
    overrides = {},
    keys = {
        ["print"]    = "<c-j>",
        ["debug"]    = "<c-d>",
        ["error"]    = "<c-x>",
        ["while"]    = "<c-w>",
        ["for"]      = "<c-f>",
        ["if"]       = "<c-i>",
        ["elseif"]   = "<c-o>",
        ["else"]     = "<c-e>",
        ["switch"]   = "<c-s>",
        ["case"]     = "<c-v>",
        ["default"]  = "<c-b>",
        ["function"] = "<c-m>",
        ["lambda"]   = "<c-l>",
        ["class"]    = "<c-k>",
        ["struct"]   = "<c-h>",
        ["try"]      = "<c-t>",
        ["enum"]     = "<c-n>"
    }
})
require("shnip").snippet("<c-p>", "()<left>")
```


### overrides
if you don't like a snippet for a particular language, or wish to add your own, you can use the `overrides` option

```lua
require("shnip").setup(
    overrides = {
        python = {  -- filetype
            extra = {
                ["<c-a>"] = "new snippet"
            },
            print = false,  -- disable a snippet
            class = "modified snippet",
        },
    }
}
```

### adding your own languages

```lua
 -- table of filetypes, table of snippets
require("shnip").addFtSnippets({"cpp"}, {
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
```
