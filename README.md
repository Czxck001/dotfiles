# dotfiles

Configuration files of Vim, Tmux, etc.

Contributions are always welcome.

**NOTE**: The sections in this document are deliberately placed in reverse order, to facilitate setting up a new BSD/Linux, when `cat README.md` could be the most convenient way to browse this file given Vim is not ready aforehand.


## Troubleshooting

### E1312 when using NERDTree and closing the last pane
This is due to the usage of a legacy feature in plugin [vim-nerdtree-tabs](https://github.com/jistr/vim-nerdtree-tabs), particularly, in [this function](https://github.com/jistr/vim-nerdtree-tabs/blob/07d19f0299762669c6f93fbadb8249da6ba9de62/nerdtree_plugin/vim-nerdtree-tabs.vim#L337C18-L341). A change in newer Vim that's introduced no later than patch 9.0.0907 makes the feature no longer working.

Since `vim-nerdtree-tabs` is no longer actively maintained, the only solution so far would be using an older version of Vim, before finding an alternative of `vim-nerdtree-tabs`. So far, Vim v8.2.4929 is guaranteed to work.

### Vim clipboard stops working in an intermittent manner (MacOS laptop + Linux remote)

The symptom is after logging in a remote server through ssh+X11 for a while, Vim clipboard will no longer sync with system clipboard. When it happens, xrestore will often succeed but won't solve the problem. Detaching and reattaching the tmux session won't work neither. The only way to get rid of the problem is deattach from tmux and re-login to the remote server via SSH, then reattach to the tmux session and execute xrestore. However, the same issue often relapses after certain period of time of using.

The issue will appear whether using tmux on the remote server or not (w/o tmux). Often, when the issue happens inside a tmux session, the tmux copying mechanism can still work, indicating it's unrelated to pasteboard connection between tmux through ssh+X11 and iTerm2.

It's finally discovered that the issue is caused by the ForwardX11Timeout mechanism of BSD's `ssh`. According to the [official document](https://man.openbsd.org/ssh_config#ForwardX11Timeout), BSD's `ssh` will refuse X11 forwarding request after establishing SSH connection of ForwardX11Timeout. By default, its duration is only 20 minutes.

When using Vim on the remote server, probably if after certain amount time of inactivity, the initial X11 forwarding connection will be cut off. After that, Vim will need to reestablish the connection by having a new X11 forwarding request, which will probably be rejected due to the short default ForwardX11Timeout of BSD's `ssh`, causing the issue that can only be solved by re-establishing the SSH connection.

With this root cause found, here comes a simple solution: edit `~/.ssh/config` on MacOS laptop and increase the duration of ForwardX11Timeout:
```
ForwardX11Timeout 596h
```
According to the official document, setting this value to 0 can disable the timeout and permit life-time connection, which should also solve this issue (not verified yet).

In a related manner, [Bracketed-paste](https://en.wikipedia.org/wiki/Bracketed-paste) will interfere with the pasteboard communication through iTerm2<->X11<->Vim. This causes some issue similar to the above but with different behaviors and rootcause. In light of this, it's recommended to disable this feature in iTerm2, which will permanently solve this issue. This disabling is often necessary because bracketed-paste is enabled by default.
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

### fzf Setup

It's in general better to let `fzf` avoid searching for some large and often meaningless folders like `.git` and `bazel-*`:

```bash
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!**/.git' --glob '!bazel-*'"
```

## Soft Linkage
```bash
ln -s $(realpath vimrc) ~/.vimrc
ln -s $(realpath gitconfig) ~/.gitconfig
ln -s $(realpath coc-settings.json) ~/.vim/coc-settings.json
ln -s $(realpath flake8) ~/.config/flake8
ln -s $(realpath tmux.conf) ~/.tmux.conf
```
