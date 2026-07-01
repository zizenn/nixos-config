return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup {
      install_dir = vim.fn.stdpath('data') .. '/site',
    }

    -- Install parsers on first run
    local parsers = { 'c', 'c++', 'lua', 'markdown', 'markdown_inline', 'latex' }
    require('nvim-treesitter').install(parsers)

    -- Enable treesitter highlight globally
    vim.api.nvim_create_autocmd('FileType', {
      pattern = '*',
      callback = function() vim.treesitter.start() end,
    })
  end,
}
