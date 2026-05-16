# =============================================================================
# Shared Shell Functions
# =============================================================================

# Create a directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Extract any archive
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.tar.xz)    tar xJf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.rar)       unrar x "$1"     ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Find a file by name
findf() {
  find . -iname "*$1*" -type f 2>/dev/null
}

# Find a directory by name
findd() {
  find . -iname "*$1*" -type d 2>/dev/null
}

# Create a backup of a file
backup() {
  cp "$1"{,.bak}
}

# Search and replace in files
replace() {
  if [ "$#" -ne 3 ]; then
    echo "Usage: replace <pattern> <replacement> <files...>"
    return 1
  fi
  local pattern="$1"
  local replacement="$2"
  shift 2
  sed -i "s/$pattern/$replacement/g" "$@"
}

# Show weather (requires wget or curl)
weather() {
  local city="${1:-}"
  if [ -n "$city" ]; then
    curl -s "wttr.in/$city?m" | head -38
  else
    curl -s "wttr.in?m" | head -38
  fi
}

# Quick HTTP server
serve() {
  local port="${1:-8000}"
  python3 -m http.server "$port"
}

# Kill a process by name
killp() {
  pkill -f "$1" 2>/dev/null && echo "Killed: $1" || echo "No process found: $1"
}

# Pretty-print JSON (uses python)
json() {
  if [ -n "$1" ]; then
    echo "$1" | python3 -m json.tool
  else
    python3 -m json.tool
  fi
}

# Get a cheat sheet for a command
cheat() {
  curl -s "https://cheat.sh/$1"
}

# Show disk usage in current directory
usage() {
  du -sh * 2>/dev/null | sort -h
}

# Convert markdown to PDF (requires pandoc)
md2pdf() {
  local input="${1:?Usage: md2pdf <input.md> [output.pdf]}"
  local output="${2:-${input%.md}.pdf}"
  pandoc "$input" -o "$output"
}
