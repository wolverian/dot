#!/usr/bin/env zsh

export LANG=C.UTF-8
export EDITOR='code-insiders --wait'

path=(
  $path
  ~/go/bin
  ~/Library/Python/3.7/bin
  ~/bin
  ~/.cargo/bin
  ~/.ghcup/bin
  ~/.cabal/bin
  ~/.local/bin
)

HISTFILE=$HOME/.zshhistory
SAVEHIST=99999999
HISTSIZE=99999999
HIST_IGNORE_DUPS=1
setopt sharehistory histignoredups

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

autoload -U compinit
compinit

prompt='%1~%% '

. .alias

