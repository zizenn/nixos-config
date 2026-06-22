return {
  -- Points Lazy to look at your ~/.config/nvim/lua/matugen directory
  dir = vim.fn.stdpath("config") .. "/lua/matugen",
  name = "matugen",
  lazy = false,
  priority = 1000, -- Forces the theme to load before anything else
  config = function()
    -- Safely require your theme module and initialize it
    local status, matugen = pcall(require, "matugen")
    if status then
      matugen.setup()
      vim.cmd("colorscheme matugen")
    else
      vim.notify("Could not load local matugen module", vim.log.levels.WARN)
    end
  end,
}
