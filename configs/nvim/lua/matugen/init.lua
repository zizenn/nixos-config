local M = {}

function M.setup()
  -- Baseline transparent fallback to guarantee zero boot errors.
  -- Your matugen generation scripts can safely overwrite or fill this file later!
  vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
end

return M
