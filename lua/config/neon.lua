local opts = {
        style = "default",
        italic_comment = true,
        italic_keyword = false,
        italic_boolean = false,
        italic_function = false,
        italic_variable = false,
        bold = false,
        transparent = true,
}

for k, v in pairs(opts) do
        vim.g["neon_" .. k] = v
end
