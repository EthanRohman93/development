# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="crunch"

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

setopt NO_BEEP
# Plugins
plugins=(
  git           # Git plugin
  zsh-autosuggestions  # Autosuggestions
  zsh-syntax-highlighting  # Syntax highlighting
  z               # Directory jumping
  web-search      # Search the web from the command line
  command-not-found  # Suggests commands when they are not found
)

# Load plugins
source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Custom Functions
function mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Set up z
. ~/z/z.sh

# Load custom environment variables
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# Custom PATH additions
export PATH="$HOME/.local/bin:$PATH"

# Enable command completion
autoload -Uz compinit
compinit

# Enable autojump
[ -s /usr/share/autojump/autojump.zsh ] && source /usr/share/autojump/autojump.zsh

# Set default editor to vim
export EDITOR='vim'

# History settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Enable color in ls
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  alias ls='ls --color=auto'
elif [[ "$OSTYPE" == "darwin"* ]]; then
  alias ls='ls -G'
fi

# Other useful configurations
setopt autocd  # Change directory just by typing its name
setopt correct  # Correct command spelling

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source <(fzf --zsh)

alias cat='bat'

# find file and open in vim
fv() {
  fzf --preview 'bat --color=always {}' \
      --preview-window 'right:50%,border-left' \
      --height 33% \
      --info inline \
      --layout reverse \
      --print0 | xargs -0 -o vim
}

# find string in files and open in vim
fsv() {
  local rg_prefix='rg --column --line-number --no-heading --color=always --smart-case'
  local initial_query="${*:-}"

  : | fzf --ansi --disabled --query "$initial_query" \
      --bind "start:reload:$rg_prefix {q}" \
      --bind "change:reload:sleep 0.1; $rg_prefix {q} || true" \
      --delimiter ':' \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
      --bind 'enter:become(vim {1} +{2})'
}

# Search and cd into the selected directory with smaller height and preview
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf \
    --height 33% \
    --info inline \
    --layout reverse \
    --preview 'ls -la {}' \
    --preview-window 'right:50%,border-left') &&
  cd "$dir"
}


# pyenv setup
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Ensure the virtualenv plugin is initialized
eval "$(pyenv virtualenv-init -)"

alias G='function _G() { if [[ -z "$VIRTUAL_ENV" ]]; then pyenv activate openai_env; fi && python ~/gpt.py "$@" && if [[ -z "$VIRTUAL_ENV" ]]; then pyenv deactivate; fi }; _G'
# export OPENAI_API_KEY=""


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias gs='git status'
