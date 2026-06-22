-- Clear out default styles cleanly
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "matugen"

-- Safely require your internal lua engine 
local status, matugen = pcall(require, "matugen")
if status and type(matugen) == "table" and type(matugen.setup) == "function" then
  matugen.setup()
end
