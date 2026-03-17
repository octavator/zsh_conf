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

# Saut de mot avec Ctrl
bindkey "\e[1;5C" forward-word  # Ctrl + Right
bindkey "\e[1;5D" backward-word # Ctrl + Left

# # Optimiser la recherche dans l'historique
bindkey "^R" history-incremental-search-backward  # Recherche incrémentielle

# Separator characters to stop at (customize this string)
ZSH_SEPARATOR_CHARS='/|,;._-:=@'

# Jump forward to next separator character
forward-to-separator() {
  local pos=$((CURSOR + 1))
  while (( pos <= ${#BUFFER} )); do
    if [[ "$ZSH_SEPARATOR_CHARS" == *"${BUFFER[pos]}"* ]]; then
      CURSOR=$pos
      return 0
    fi
    (( pos++ ))
  done
  CURSOR=${#BUFFER}
}

# Jump backward to previous separator character
backward-to-separator() {
  local pos=$((CURSOR - 1))
  while (( pos >= 1 )); do
    if [[ "$ZSH_SEPARATOR_CHARS" == *"${BUFFER[pos]}"* ]]; then
      CURSOR=$pos
      return 0
    fi
    (( pos-- ))
  done
  CURSOR=0
}

zle -N forward-to-separator
zle -N backward-to-separator

# Option + Right/Left → jump to next/previous separator
bindkey "\e[1;3C" forward-to-separator   # Option + Right
bindkey "\e[1;3D" backward-to-separator  # Option + Left

# Jump forward to next blank (space/tab)
forward-to-blank() {
  local pos=$((CURSOR + 1))
  while (( pos <= ${#BUFFER} )); do
    if [[ ${BUFFER[pos]} == [[:blank:]] ]]; then
      CURSOR=$pos
      return 0
    fi
    (( pos++ ))
  done
  CURSOR=${#BUFFER}
}

# Jump backward to previous blank (space/tab)
backward-to-blank() {
  local pos=$((CURSOR - 1))
  while (( pos >= 1 )); do
    if [[ ${BUFFER[pos]} == [[:blank:]] ]]; then
      CURSOR=$pos
      return 0
    fi
    (( pos-- ))
  done
  CURSOR=0
}

zle -N forward-to-blank
zle -N backward-to-blank

# Option + Ctrl + Right/Left → jump to next/previous blank
bindkey "\e[1;7C" forward-to-blank   # Option + Ctrl + Right
bindkey "\e[1;7D" backward-to-blank  # Option + Ctrl + Left

# Delete backward to previous separator character
backward-delete-to-separator() {
  local pos=$((CURSOR - 1))
  while (( pos >= 1 )); do
    if [[ "$ZSH_SEPARATOR_CHARS" == *"${BUFFER[pos]}"* ]]; then
      break
    fi
    (( pos-- ))
  done
  BUFFER="${BUFFER[1,pos]}${BUFFER[$((CURSOR + 1)),${#BUFFER}]}"
  CURSOR=$pos
}

# Delete backward to previous blank (space/tab)
backward-delete-to-blank() {
  local pos=$((CURSOR - 1))
  while (( pos >= 1 )); do
    if [[ ${BUFFER[pos]} == [[:blank:]] ]]; then
      break
    fi
    (( pos-- ))
  done
  BUFFER="${BUFFER[1,pos]}${BUFFER[$((CURSOR + 1)),${#BUFFER}]}"
  CURSOR=$pos
}

zle -N backward-delete-to-separator
zle -N backward-delete-to-blank

# Option + Delete → delete backward to previous separator
# Requires iTerm2 key mapping: Option+Delete → Send Escape Sequence → [3;3~
bindkey "\e[3;3~" backward-delete-to-separator       # Option + Delete
# Option + Ctrl + Delete → delete backward to previous blank
bindkey "\e[3;7~" backward-delete-to-blank           # Option + Ctrl + Delete