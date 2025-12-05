# Preloads ZSH custom hooks function
autoload -U add-zsh-hook

export PROMPT='%B%F{green}%~%f%b %# '
alias python="python3"

alias zshconfig="code ~/.zshrc"  # Ouvrir la config Zsh dans VS Code
alias zshreload="source ~/.zshrc" # Recharger la config

# Activer la correction automatique des commandes
# setopt CORRECT
# setopt CORRECT_ALL

## SSH
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/personal_gh_key
ssh-add ~/.ssh/id_rsa_hostinger

## Elixir
export ERL_AFLAGS="-kernel shell_history enabled" ## Activate history in erlang Shell
alias exmix="iex -S mix"

alias ll="ls -la"

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

alias vpnfix="sudo launchctl unload /Library/LaunchDaemons/kbrw.strongswan.plist"
alias infra-cli="~/Documents/chef-repo/tools/infra-cli"
alias glg="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all"
alias gb='git branch'
alias gbr='git branch --remote'
alias gd='git diff'
alias gs='git show'
alias grma='git rebase master'
alias gf='git fetch'
alias gu='gsh && gpl && gshp'
alias gC="grep -C"

git config --global column.ui auto
git config --global branch.sort -committerdate
#@TODO; git pull proper config


## Unused async processes for terminal for now
# source ~/.zsh_config/async.zsh

# Activate custom prompt
add-zsh-hook precmd _vbe_setprompt


## PATH MANIPULATION
export PATH="/opt/homebrew/bin:/usr/local/lib/ruby/gems/3.1.0/bin:/usr/local/opt/ruby/bin:/Users/theophiledecagny/.asdf/shims:/usr/local/opt/asdf/libexec/bin:/usr/local/opt/node@12/bin:/Users/theophiledecagny/Documents/distmix:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:~/Documents/chef-repo/tools"
export PATH=/usr/local/bin:$PATH
export PATH=/Users/theophiledecagny/Documents:$PATH
export PATH=/Users/theophiledecagny/.local/bin:$PATH

for file in ~/.zsh_config/*.zsh; do
    source "$file"
done


eval "$(chef shell-init zsh)"