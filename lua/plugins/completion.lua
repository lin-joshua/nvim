return {
  {
    "saghen/blink.cmp",
    version = "1.*", -- prebuilt fuzzy-matching binary
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
      keymap = {
        preset = "enter",
        -- Tab/S-Tab walk the menu when it is open, otherwise jump snippet placeholders.
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },
      -- Signature popup that appears on "(" and tracks the current argument.
      signature = { enabled = true },
      completion = {
        documentation = { auto_show = true },
      },
    },
  },
}
