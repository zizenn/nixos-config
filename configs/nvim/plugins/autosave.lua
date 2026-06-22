return {
  "okuuva/auto-save.nvim",
  event = { "BufEnter", "InsertLeave", "BufLeave" },
  opts = {
    enabled = true,
    trigger_events = {
      immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" },
      defer_save = { "InsertLeave" },
      cancel_deferred_save = { "InsertEnter" },
    },
    debounce_delay = 1000,
    noautocmd = true,
  },
}
