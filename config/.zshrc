# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM="xterm-256color"
export ZSH=$HOME/.oh-my-zsh
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
if [ -d /opt/local/bin ]; then
    export PATH=$PATH:/opt/local/bin
fi

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git git-extras python pip cp colorize
)

# Aliases
\which sf-pwgen > /dev/null 2>&1 && alias pwgen='sf-pwgen -l 32'
alias pip-upgrade='pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U'

# Tools
if [ -f "/usr/local/opt/nvm/nvm.sh" ] || [ -f "$HOME/.nvm/nvm.sh" ]; then
  export NVM_DIR="$HOME/.nvm"
  if [ -f "/usr/local/opt/nvm/nvm.sh" ]; then
    source "/usr/local/opt/nvm/nvm.sh"
  elif [ -f "$HOME/.nvm/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
  fi
  plugins+=(nvm)
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv init --path)"
  eval "$(pyenv virtualenv-init -)"
fi

# Linux
[ -f /usr/share/autojump/autojump.sh ] && source /usr/share/autojump/autojump.sh && plugins+=(autojump)
# Homebrew
[ -f /usr/local/etc/profile.d/autojump.sh ] && source /usr/local/etc/profile.d/autojump.sh && plugins+=(autojump)
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh && plugins+=(autojump)
# MacPorts
[ -f /opt/local/etc/profile.d/autojump.sh ] && source /opt/local/etc/profile.d/autojump.sh && plugins+=(autojump)


command -v kubectl >/dev/null 2>&1 && plugins+=(kubectl kubectx)
command -v aws >/dev/null 2>&1 && plugins+=(aws)
command -v aws-vault >/dev/null 2>&1 && plugins+=(zsh-aws-vault)
command -v docker >/dev/null 2>&1 && plugins+=(docker)
command -v brew >/dev/null 2>&1 && plugins+=(brew)

# Use curl from homebrew
[ -d /opt/homebrew/opt/curl/bin ] && export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# PATHS
if command -v go >/dev/null 2>&1; then
  export GOPATH="$HOME/go"
  export PATH="$HOME/go/bin:$PATH"
fi

[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -d "$HOME/scripts" ] && export PATH="$HOME/scripts:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
if [ -f "$HOME/.rvm/scripts/rvm" ]; then
  export PATH="$PATH:$HOME/.rvm/bin"
  source $HOME/.rvm/scripts/rvm
fi

if [ -f ~/.zshenv ]; then
  source ~/.zshenv
fi

# Customizations
[ -f /usr/share/google-cloud-sdk/completion.zsh.inc ] && source /usr/share/google-cloud-sdk/completion.zsh.inc
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

source $ZSH/oh-my-zsh.sh

# Separate history for each session
unsetopt inc_append_history
unsetopt share_history

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Fix problem with "gpg: signing failed: Inappropriate ioctl for device" with git
export GPG_TTY=$(tty)

batdiff() {
    git diff --name-only --relative --diff-filter=d -z | xargs -0 bat --diff
}
