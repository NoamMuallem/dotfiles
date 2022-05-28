require("neogit").setup({
  kind = "tab",
  signs = {
    -- { CLOSED, OPENED }
    section = { "", "" },
    item = { "", "" },
    hunk = { "", "" },
  },
  integrations = { diffview = true },
})
