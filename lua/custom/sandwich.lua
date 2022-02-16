local pkg = {}

function pkg.add_surround(left, right)
  vim.list_extend(
    vim.g["sandwich#recipes"],
    {buns = {left, right}}
  )
end

return pkg
