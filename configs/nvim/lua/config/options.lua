-- Options
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorlineopt = "number"

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.shiftround = true

opt.wrap = false
opt.linebreak = true
opt.breakindent = true

opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "nosplit"

opt.termguicolors = true
opt.signcolumn = "yes"
opt.numberwidth = 4
opt.scrolloff = 8
opt.sidescrolloff = 8

opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"

opt.undofile = true
opt.undolevels = 10000
opt.undodir = vim.fn.stdpath("data") .. "/undo"

opt.updatetime = 200
opt.timeoutlen = 300
opt.ttimeoutlen = 10

opt.mouse = "a"
opt.mousemodel = "popup"

opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect,preview"
opt.pumheight = 10
opt.pumblend = 10

opt.wildmode = "longest:full,full"
opt.wildignorecase = true
opt.wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.class,*.pdf,*.dylib,*.so"

opt.list = true
opt.listchars = { tab = "▸ ", trail = "·", nbsp = "␣", extends = "»", precedes = "«" }

opt.fillchars = { eob = " ", fold = " ", foldopen = "▾", foldsep = "│", foldclose = "▸" }
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = ""

opt.virtualedit = "block"
opt.inccommand = "split"
opt.confirm = true
opt.autowrite = true
opt.autoread = true

opt.conceallevel = 2
opt.concealcursor = "nc"

opt.swapfile = false
opt.backup = false
opt.writebackup = false

opt.spelllang = "en_us"
opt.spelloptions = "camel"

opt.shortmess:append("cCFSIW")
opt.shortmess:append("s")

opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

opt.formatoptions:remove("o")
opt.formatoptions:append("j")

opt.diffopt:append("linematch:60")

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
end

if vim.fn.has("nvim-0.11") == 1 then
  opt.smoothscroll = true
  opt.foldmethod = "expr"
  opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
end

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0