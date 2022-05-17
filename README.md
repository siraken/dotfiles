# dot Files

An repository that manages dotfiles `.*` under my home directory.

Place this repository on `username/dotfiles` and run an excutable file `symlink`.

## Shell

- [fish](https://fishshell.com/)
  - [fisher](https://github.com/jorgebucaran/fisher)
  - [IlanCosman/tide](https://github.com/IlanCosman/tide)
- [Zsh](https://zsh.org/)
  - [Oh My Zsh](https://ohmyz.sh/)
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
  - [romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [Starship](https://starship.rs/)

## Neovim

- [junegunn/vim-plug](https://github.com/junegunn/vim-plug)
  - Add plugins to `nvim/plug.vim` and run `:PlugInstall`.
  - To remove plugins, comment out or delete the statement of the plugin and run `:PlugClean`

### Coc

```bash
:CocInstall coc-html
:CocInstall coc-tsserver
:CocInstall coc-json
```
