# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="crunch"

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Plugins
plugins=(
  git           # Git plugin
  zsh-autosuggestions  # Autosuggestions
  zsh-syntax-highlighting  # Syntax highlighting
  z               # Directory jumping
  sudo            # Enables sudo to be used as a prefix for the previous command
  web-search      # Search the web from the command line
  command-not-found  # Suggests commands when they are not found
)

# Load plugins
source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Custom Aliases
alias ll='ls -la'
alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias gp='git push'
alias gpl='git pull'

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
setopt auto_pushd  # Automatically push directories onto the stack
setopt pushd_ignore_dups  # Ignore duplicate directories in the stack
setopt pushdminus  # List the contents of the directory stack with "dirs"
setopt correct  # Correct command spelling

