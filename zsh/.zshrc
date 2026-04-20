export PATH="/usr/local/bin:$PATH:$HOME/bin:$HOME/.local/bin"

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
alias k=kubectl
alias ld=lazydocker
alias t=tmux
alias cld=claude
alias dkrup='open /Applications/Docker.app'
alias dkr=docker
alias p=pnpm
alias cldd='claude --dangerously-skip-permissions' 

# third parties
eval "$(/opt/homebrew/bin/brew shellenv)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# nvim
export NVM_DIR="$HOME/.nvim"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

function asp() {
  local profile
  profile=$(aws configure list-profiles | sort | fzf --height=10 --prompt="Select AWS_PROFILE: ") || return

  if [[ -n "$profile" ]]; then
    export AWS_PROFILE="$profile"
    echo "✅ AWS_PROFILE set to: $AWS_PROFILE"
    echo "🔐 Logging in with SSO..."
    aws sso login --profile "$AWS_PROFILE"
  else
    echo "❌ No profile selected."
  fi
}
