local fn = vim.fn
local execute = vim.api.nvim_command

-- Auto install packer.nvim if not exists
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

-- Use neovim virtualenv for Python3 host
vim.cmd([[let g:python3_host_prog='/home/hactar/.pyenv/versions/neovim/bin/python']])
vim.cmd([[packadd packer.nvim]])
-- vim.cmd("autocmd BufWritePost plugins.lua PackerCompile") -- Auto compile when there are changes in plugins.lua

require("plugins")
require("settings")
require("theme")
require("maps")
