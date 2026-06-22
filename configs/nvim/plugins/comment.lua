return {
  "numToStr/Comment.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ---LHS of both mapping types
    ---@type table
    mappings = {
      ---operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
      basic = true,
      ---extra mapping; `gco`, `gcO`, `gcA`
      extra = true,
    },
  },
}
