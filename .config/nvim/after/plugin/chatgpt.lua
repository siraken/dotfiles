local status, gpt = pcall(require, 'chatgpt')
if (not status) then return end

-- FIXME: does not work
gpt.setup {}
