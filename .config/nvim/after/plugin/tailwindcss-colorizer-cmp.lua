local status, tailwind = pcall(require, 'tailwindcss-colorizer-cmp')
if (not status) then return end

tailwind.setup {}
