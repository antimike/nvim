return {
  --- Search files from project root using Telescope
  switch_project = function()
    require("telescope.builtin").find_files ({
      prompt_title = "< Switch Project >",
      cwd = "$HOME/Source",
    })
  end
}
