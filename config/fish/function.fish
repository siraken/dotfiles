function gd
    set dir (gd-select)
    test -n "$dir"; and cd $dir
end
