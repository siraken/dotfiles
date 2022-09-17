local status, deepl = pcall(require, 'deepl-commmands')
if (not status) then return end

deepl.setup {
  selector_func = require 'fzyselect'.start,
  default_target = 'EN',
}
