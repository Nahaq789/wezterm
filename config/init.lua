local wezterm = require('wezterm')

---@class Config
---@field options table
local Config = {}
Config.__index = Config

---Initialize Config
---@return Config
function Config:init()
   local config = setmetatable({ options = {} }, self)

   -- クリップボード関連の設定
   config.keys = {
      -- コピー: Ctrl + C
      {
         key = 'c',
         mods = 'CTRL',
         action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
      },
      -- ペースト: Ctrl + V
      {
         key = 'v',
         mods = 'CTRL',
         action = wezterm.action.PasteFrom 'Clipboard',
      },
   }
   return config
end

---Append to `Config.options`
---@param new_options table new options to append
---@return Config
function Config:append(new_options)
   for k, v in pairs(new_options) do
      if self.options[k] ~= nil then
         wezterm.log_warn(
            'Duplicate config option detected: ',
            { old = self.options[k], new = new_options[k] }
         )
         goto continue
      end
      self.options[k] = v
      ::continue::
   end
   return self
end

return Config
