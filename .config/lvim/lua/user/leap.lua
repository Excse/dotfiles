local ok, leap = pcall(require, "leap")
if not ok then
  return
end

leap.set_default_keymaps(true)

leap.setup({
  case_sensitive = false,
  safe_labels = {},
  max_phase_one_targets = 0,
  max_highlighted_traversal_targets = 10,
})

-- Bidirectional search
local function leap_current_window()
  leap.leap({ target_windows = { vim.api.nvim_get_current_win() } })
end
vim.keymap.set("n", "s", leap_current_window, { silent = true })
vim.keymap.set("x", "s", leap_current_window, { silent = true })

-- mark cursor location before jumping
vim.api.nvim_create_autocmd("User", {
  pattern = "LeapEnter",
  callback = function()
    vim.cmd("normal m'")
  end,
})

-- center cursor after jumping
vim.api.nvim_create_autocmd("User", {
  pattern = "LeapLeave",
  callback = function()
    vim.cmd("normal zz")
  end,
})
