# Preloads ZSH custom hooks function
autoload -U add-zsh-hook

export PROMPT='%B%F{green}%~%f%b %# '
export EDITOR="code"
export HOMEBREW_NO_ANALYTICS=1
plugins=(git ssh-agent)
alias python="python3"
# Maybe needed ?
# export ZSH=$HOME/.oh-my-zsh

alias zshconfig="code ~/.zshrc"  # Ouvrir la config Zsh dans VS Code
alias zshreload="source ~/.zshrc" # Recharger la config

# Activer la correction automatique des commandes
# setopt CORRECT
# setopt CORRECT_ALL

## SSH
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_ed25519

alias ll="ls -la"
alias gC="grep -C"
alias c="code ."

## GIT
alias st="git status"
alias gp="git push"
alias gpl="git pull"
alias gl="git log"
alias gco="git checkout"
alias gcoma="git checkout master"
alias gcopp="git checkout preprod"
alias gcoprod="git checkout production"
alias gsh="git stash push"
alias gshp="git stash pop"
alias gap="git add -p"
alias gcp="git cherry-pick"
alias gcm="git commit -m"
alias gbD="git branch -D"
alias glg="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all"
alias gb='git branch'
alias gbr='git branch --remote'
alias gd='git diff'
alias gs='git show'
alias grma='git rebase master'
alias gf='git fetch'
alias gu='gsh && gpl && gshp'
alias gpr="gh pr view --web"

git config --global column.ui auto
git config --global branch.sort -committerdate

alias git='LC_ALL=en_GB git'


## Ruby
alias r="rubocop -A"
alias t="DISABLE_SPRING=1 rails test test "
alias rs="SIDEKIQ_INLINE=true bundle exec rails s -p 3000"

#@TODO; git pull proper config ff.only/rebase


## Unused async processes for terminal for now
# source ~/.zsh_config/async.zsh

# Activate custom prompt
add-zsh-hook precmd _vbe_setprompt

## DIFT
export DIFT="~/Documents/dift/"
export PKG_CONFIG_PATH="/opt/homebrew/opt/postgresql@15/lib/pkgconfig"

## PATH MANIPULATION
export PATH="/opt/homebrew/bin:/usr/local/opt/ruby/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/opt/homebrew/opt/imagemagick@6/bin:$PATH"
export PATH="~/.rbenv/shims:$PATH"


for file in ~/.zsh_config/*.zsh; do
    source "$file"
done

# Added by `rbenv init` on lun. 16 mars 2026 14:01:12 CET
eval "$(rbenv init - --no-rehash zsh)"
export PATH="$HOME/.local/bin:$PATH"
