#!/bin/bash

case $(uname) in
"Darwin" | "Linux")
    # Packer
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
;;
*)
    # Packer: Windows or other
    git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
;;
esac
