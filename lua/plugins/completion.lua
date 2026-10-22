return {
  {
    "saghen/blink.cmp",
    version = "1.*", -- prebuilt fuzzy-matching binary
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
      keymap = { preset = "default" },
      -- Signature popup that appears on "(" and tracks the current argument.
      signature = { enabled = true },
      completion = {
        documentation = { auto_show = true },
      },
    },
  },
}
