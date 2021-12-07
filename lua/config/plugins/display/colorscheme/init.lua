return {
    { 'sainnhe/gruvbox-material' },
    { 'sainnhe/edge' },
    { 'folke/tokyonight.nvim' },
    { 'bluz71/vim-nightfly-guicolors' },
    { 'bluz71/vim-moonfly-colors' },
    { 'shaunsingh/nord.nvim' },
    { 'navarasu/onedark.nvim' },
    { 'wuelnerdotexe/vim-enfocado' },
    {
        'norcalli/nvim-colorizer.lua',
        event = 'BufRead',
        config = function()
            local present, color = pcall(require, 'colorizer')
            if not present then
                return
            end

            color.setup {
                '*',
                css = { rgb_fn = true; }
            }
            vim.cmd('ColorizerAttachToBuffer')
        end
    }
}
