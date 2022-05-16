# dot Files

An repository that manages dotfiles `.*` under my home directory.

Place this repository on `username/dotfiles` and run an excutable file `symlink`.

## fisher

`curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher`

## nvim

Run the command below to  install `vim-plug`

```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

- Add plugins to `nvim/plug.vim` and run `:PlugInstall`.
- To remove plugins, comment out or delete the statement of the plugin and run `:PlugClean`

## Coc

```bash
:CocInstall coc-html
:CocInstall coc-tsserver
:CocInstall coc-json
```
