function gd
    set dir (gd-select)
    test -n "$dir"; and cd $dir
end

# gau - Git Add URL
# Add git remote URL with current directory name
function gau
    echo "Enter the username:" && read username

    if test -n "$username"
        git remote add origin "https://github.com/$username/"(basename (pwd))".git"
        git remote -v
    else
        echo "Please provide the username you want to use."
    end
end
