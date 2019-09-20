#!/usr/bin/env zsh

export LANG=en_US.UTF-8
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

alias g=git
alias gc='git commit -v'
alias gd='git diff'
alias gp='git push'
alias gs='git status -sb'
alias ga='git add'
alias gl='git log --oneline --decorate --graph'
alias gw='git switch'
alias gb='git branch -v'
alias gr='git restore'
alias gu='git pull --rebase'

