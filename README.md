# dot Files

An repository that manages dotfiles `.*` under my home directory.

Place this repository on `username/dotfiles` and run an excutable file `symlink`.

## fisher

`curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher`

## vim

Run the command below to install `vim-plug`

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

- Add plugins to `.vimrc` and run `:PlugInstall`.
- To remove plugins, comment out or delete the statement of the plugin and run `:PlugClean`

## nvim

Run the command below to  install `vim-plug`

```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

## Coc

```bash
:CocInstall coc-html
:CocInstall coc-tsserver
:CocInstall coc-json
```
