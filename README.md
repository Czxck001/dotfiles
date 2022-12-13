# dotfiles

Configuration files of Vim, Tmux, etc.

Contributions are always welcome.

### fzf Setup

It's in general better to let `fzf` avoid searching for some large and often meaningless folders like `.git` and `bazel-*`:

```bash
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!**/.git' --glob '!bazel-*'"
```

## Troubleshooting

### Vim clipboard stops working in an intermittent manner
The symptom is after logging in a remote server through ssh+X11 for a while, Vim clipboard will no longer sync with system clipboard. When it happens, xrestore will often succeed but won't solve the problem. Detaching and reattaching the tmux session won't work neither. The only way to get rid of the problem is deattach from tmux and re-login to the remote server via SSH, then reattach to the tmux session and execute xrestore. However, the same issue often relapses after certain period of time of using. 

The exact trigger to the issue is still unknown, causing it very difficult to debug. The issue will appear whether using tmux on the remote server or not. Often, when the issue happens inside a tmux session, the tmux copying mechanism can still work, indicating it's unrelated to pasteboard connection between tmux through ssh+X11 and iTerm2.

It's finally discovered that [Bracketed-paste](https://en.wikipedia.org/wiki/Bracketed-paste) will interfere with the pasteboard communication through iTerm2<->X11<->Vim. In light of this, it's highly recommended to disable this feature in iTerm2, which will permanently solve this issue. This disabling is often necessary because bracketed-paste is enabled by default.
- iTerm2 (3.4.18) -> Preference -> Profiles -> Terminal -> disable the option of "Terminal may enable paste bracketing".

### Vim's `E353: Nothing in register +` after reattaching to a tmux session


In `vimrc`, the clipboard is configured to `unnamedplus` whenever X11 is available. This enables a synchronized clipboard when executing Vim on a remote server via an SSH session with X11 forwarded.

This mechanism works with plain shell-over-SSH as well as with tmux. However, if one opened Vim in a remote tmux session, deattached the session and logout SSH, then log back and reattach to the same tmux session, the clipboard will no longer work and will throw the error "E353: Nothing in register +".

The solution would be working with Vim newer than 8.1.1307 on the remote server, then after tmux reattachment, execute
```
:xrestore
```
in the Vim console.

In `vimrc`, an alias `:R` is created as a shortcut to the `:xrestore` command.

Also see
- https://github.com/vim/vim/issues/203
- https://github.com/vim/vim/pull/844

## Vim Setup

a) Install [vim-plug](https://github.com/junegunn/vim-plug):

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

b) Use vim-plug to install plugins:

```
:PlugInstall
```

c) Install [ccls](https://github.com/MaskRay/ccls).

d) [Configure ccls for coc.nvim](https://github.com/MaskRay/ccls/wiki/coc.nvim).

e) Install [coc-pyright](https://github.com/fannheyward/coc-pyright).

f) Install [svls](https://github.com/dalance/svls).

## Tmux Setup

Install [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm):

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Soft Linkage
```bash
ln -s $(realpath vimrc) ~/.vimrc
ln -s $(realpath gitconfig) ~/.gitconfig
ln -s $(realpath coc-settings.json) ~/.vim/coc-settings.json
ln -s $(realpath flake8) ~/.config/flake8
ln -s $(realpath tmux.conf) ~/.tmux.conf
```
