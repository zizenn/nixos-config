local leet_arg = "leetcode.nvim"

return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  cmd = "Leet",
  lazy = leet_arg ~= vim.fn.argv(0, -1),
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    arg = leet_arg,
    lang = "cpp",
    cn = {
      enabled = false,
      translator = true,
      translate_problems = true,
    },
    plugins = {
      non_standalone = true,
    },
    logging = true,
    injector = {},
    cache = {
      update_interval = 60 * 60 * 24 * 7,
    },
    editor = {
      reset_previous_code = true,
      fold_imports = true,
    },
    console = {
      open_on_runcode = true,
      dir = "row",
      size = {
        width = "90%",
        height = "75%",
      },
      result = {
        size = "60%",
      },
      testcase = {
        virt_text = true,
        size = "40%",
      },
    },
    description = {
      position = "left",
      width = "40%",
      show_stats = true,
    },
    picker = {
      provider = "telescope",
    },
    keys = {
      toggle = { "q" },
      confirm = { "<CR>" },
      reset_testcases = "r",
      use_testcase = "U",
      focus_testcases = "H",
      focus_result = "L",
    },
    theme = {},
    image_support = false,
  },
}
