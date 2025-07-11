# -*- sh -*-
autoload -U zutil

autoload compinit && {
    ZSH=${ZSH:-~/.zsh}  # Définit un chemin par défaut si $ZSH n'existe pas
    mkdir -p $ZSH/run/u/$HOST-$UID  # Crée le dossier s'il n'existe pas

    autoload -U complist
    
    compinit -i -d $ZSH/run/u/$HOST-$UID/zcompdump
}

setopt auto_menu
setopt auto_remove_slash
setopt complete_in_word
setopt always_to_end
setopt glob_complete
unsetopt list_beep

# Rend la complétion sensible à la casse
#setopt NO_case_glob

zstyle ':completion:*' completer _expand_alias _complete _match _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:processes' command "ps -eo pid,user,comm,cmd -w -w"
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH/run/u/$HOST-$UID/cache/
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:history-words:*' remove-all-dups true

## Autocompletion Docker
# zstyle ':completion:*:*:docker:*' option-stacking yes
# zstyle ':completion:*:*:docker-*:*' option-stacking yes

## Autocompletion Git => @TODO; rajouter d'autres CMD GIT ?
zstyle ':completion:*:*:git-fetch:argument-rest:' tag-order '!remote-repositories'
zstyle ':completion:*:*:git-pull:argument-1:' tag-order '!remote-repositories'

#Activer la couleur sur l'auto-completion
#zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# In menu, select items with space
zmodload -i zsh/complist
bindkey -M menuselect " " accept-and-menu-complete


# Chargement d'asdf (pour Apple Silicon)
if [ -f /opt/homebrew/opt/asdf/libexec/asdf.sh ]; then
  source /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

# Initialisation des plugins asdf (exemple pour Node.js)
if [ -f ~/.asdf/plugins/nodejs/set-global-node-path.zsh ]; then
  source ~/.asdf/plugins/nodejs/set-global-node-path.zsh
fi