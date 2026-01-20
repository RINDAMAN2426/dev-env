export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# zsh opts (minimal)
setopt AUTO_CD
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt NO_BEEP
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# completions
autoload -Uz compinit
compinit -C

# plugins
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# aliases
alias v=nvim
alias lg=lazygit
alias tf=terraform
alias asp='export AWS_PROFILE=$(aws configure list-profiles | sort | fzf --height=~10)'
alias k=kubectl
alias gcb='git branch --show-current | tr -d "\n" | pbcopy'

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

## nvim
export NVM_DIR="$HOME/.nvim"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

