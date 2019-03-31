# dotfiles
Configuration files of Vim, Zsh, ConEmu, etc.

## Soft Linkage
```bash
ln -s vimrc ~/.vimrc
ln -s gitconfig ~/.gitconfig
```

## Vim Setup

a) Install [vim-plug](https://github.com/junegunn/vim-plug):

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

b) Use vim-plug to install plugins:

```
:PlugInstall 
```

c) Install [ccls](https://github.com/MaskRay/ccls).

d) [Configure ccls for coc.nvim](https://github.com/MaskRay/ccls/wiki/coc.nvim).

