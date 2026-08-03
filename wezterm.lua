local wezterm = require('wezterm')
local Config = require('config')

require('utils.backdrops')
   :set_images()
   :random()

require('events.left-status').setup()
require('events.right-status').setup({ date_format = '%a %H:%M:%S' })
require('events.tab-title').setup({ hide_active_tab_unseen = false, unseen_icon = 'circle' })
require('events.new-tab-button').setup()

wezterm.on('gui-startup', function(cmd)
   local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
   -- 右側に分割
   pane:split({
      direction = 'Right',
      size = 0.5,
   })
end)

return Config:init()
   :append(require('config.appearance'))
   :append(require('config.bindings'))
   :append(require('config.domains'))
   :append(require('config.fonts'))
   :append(require('config.general'))
   :append(require('config.launch'))
   :append({
      set_environment_variables = {
         no_proxy = 'localhost,127.0.0.1,::1',
         NO_PROXY  = 'localhost,127.0.0.1,::1',
      },
   }).options