# Search history

# Make combo waiting time extrashort for extra reactivity
export KEYTIMEOUT=1

# Load functions up-line-or-beginning-search & down-line-or-beginning-search from Zsh modules.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

# Save functions as ZLE widgets (Zsh Line Editor) allowing to bind them to keys as shortcuts
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Bind up & down arrows to these ZLE functions
bindkey "\e[A" up-line-or-beginning-search # Up
bindkey "\e[B" down-line-or-beginning-search # Down

# Saut de mot avec Option (macOS)
bindkey "\e[1;3C" forward-word   # Option + Right
bindkey "\e[1;3D" backward-word  # Option + Left

# Saut de mot avec Ctrl (si jamais utile ailleurs)
bindkey "\e[1;5C" forward-word  # Ctrl + Right (désactivé par macOS)
bindkey "\e[1;5D" backward-word # Ctrl + Left (désactivé par macOS)

# # Optimiser la recherche dans l'historique
bindkey "^R" history-incremental-search-backward  # Recherche incrémentielle

# Fonction pour sauter vers le prochain underscore (macOS)
# Fonction optimisée pour sauter vers le prochain underscore (Zsh 5.9+)
forward-to-underscore() {
  local pos=$((CURSOR + 1))
  while (( pos <= ${#BUFFER} )); do
    if [[ ${BUFFER[pos]} == '_' ]]; then
      CURSOR=$pos
      return 0
    fi
    (( pos++ ))
  done
  CURSOR=${#BUFFER}  # Fin de ligne si aucun underscore trouvé
}

# Fonction optimisée pour sauter vers le underscore précédent
backward-to-underscore() {
  local pos=$((CURSOR - 1))
  while (( pos >= 1 )); do
    if [[ ${BUFFER[pos]} == '_' ]]; then
      CURSOR=$pos
      return 0
    fi
    (( pos-- ))
  done
  CURSOR=0  # Début de ligne si aucun underscore trouvé
}

# Enregistre les widgets
zle -N forward-to-underscore
zle -N backward-to-underscore

# Associe les raccourcis (ex: Option + Maj + Right/Left)
bindkey "\e[1;7C" forward-to-underscore   # Option + CTRL + Right
bindkey "\e[1;7D" backward-to-underscore  # Option + CTRL + Left