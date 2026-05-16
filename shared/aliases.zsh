# =============================================================================
# Shared Aliases
# =============================================================================

# ---- Shell ----
alias c="clear"
alias q="exit"
alias reload="exec $SHELL -l"
alias path='echo -e "${PATH//:/\\n}"'

# ---- Listing ----
alias ls="ls -G"
alias ll="ls -lah"
alias la="ls -A"
alias l="ls -lh"

# ---- Git ----
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gl="git log --oneline --graph --decorate -20"
alias gco="git checkout"
alias gb="git branch"
alias gd="git diff"
alias gst="git stash"
alias gcl="git clone"
alias gpf="git push --force-with-lease"
alias glog="git log --oneline --decorate --graph"

# ---- Navigation ----
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"

# ---- Dev ----
alias dev="cd ~/Coding"
alias dots="cd ~/Coding/personal/dotfiles"
alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'

# ---- Utilities ----
# alias cat="bat --paging=never"  # bat is opt-in, install via brew/apt
alias df="df -h"
alias du="du -h -c"
alias free="vm_stat"
alias ip="curl -s ifconfig.me"
alias localip="ipconfig getifaddr en0"
alias myip="curl -s https://api.ipify.org"

# ---- Docker ----
alias d="docker"
alias dps="docker ps"
alias dc="docker compose"
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias dcl="docker compose logs -f"

# ---- Kubectl ----
alias k="kubectl"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kl="kubectl logs"
alias kgp="kubectl get pods"
alias kgs="kubectl get services"
alias kgd="kubectl get deployments"

# ---- OpenTofu ----
alias tf="tofu"
alias tfp="tofu plan"
alias tfa="tofu apply"
alias tfd="tofu destroy"
alias tff="tofu fmt"
