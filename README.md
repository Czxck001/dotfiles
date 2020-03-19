# dotfiles

Configuration files of Vim, Zsh, ConEmu, etc.

## Soft Linkage
```bash
ln -s $(realpath vimrc) ~/.vimrc
ln -s $(realpath gitconfig) ~/.gitconfig
ln -s $(realpath coc-settings.json) ~/.vim/coc-settings.json
ln -s $(realpath flake8) ~/.config/flake8
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

e) Install [coc-python](https://github.com/neoclide/coc-python).
