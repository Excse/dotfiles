local ok, copilot_cmp = pcall(require, "copilot-cmp")
if not ok then
  return
end

copilot_cmp.setup({
  suggestion = { enabled = false },
  panel = { enabled = false }
})
