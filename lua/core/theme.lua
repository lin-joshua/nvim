-- local M = {}
-- 
-- local active_scheme = nil
-- local timer = nil
-- 
-- local function macos_is_dark()
--   if vim.fn.has("macunix") ~= 1 then
--     return false
--   end
-- 
--   local output = vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
--   return vim.v.shell_error == 0 and output:match("Dark") ~= nil
-- end
-- 
-- local function apply()
--   local is_dark = macos_is_dark()
--   local background = is_dark and "dark" or "light"
--   local scheme = is_dark and "catppuccin-frappe" or "catppuccin-latte"
-- 
--   if active_scheme == scheme and vim.o.background == background then
--     return
--   end
-- 
--   vim.o.background = background
--   vim.cmd("colorscheme " .. scheme)
--   active_scheme = scheme
-- end
-- 
-- function M.setup()
--   if timer and not timer:is_closing() then
--     timer:stop()
--     timer:close()
--   end
-- 
--   apply()
-- 
--   local group = vim.api.nvim_create_augroup("SystemThemeSync", { clear = true })
-- 
--   vim.api.nvim_create_autocmd({ "FocusGained", "VimEnter" }, {
--     group = group,
--     callback = apply,
--   })
-- 
--   timer = (vim.uv or vim.loop).new_timer()
--   timer:start(0, 10000, vim.schedule_wrap(apply))
-- 
--   vim.api.nvim_create_autocmd("VimLeavePre", {
--     group = group,
--     callback = function()
--       if timer and not timer:is_closing() then
--         timer:stop()
--         timer:close()
--       end
--     end,
--   })
-- end
-- 
-- return M

local M = {}

function M.setup()
  vim.o.background = "dark"
  vim.cmd("colorscheme carbonfox")
end

return M
