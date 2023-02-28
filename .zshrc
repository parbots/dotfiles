# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="/Users/pickle/.oh-my-zsh"

# Set the zsh theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set update frequency to every 7 days
zstyle ':omz:update' frequency 7

# Standard plugins can be found in ~/.oh-my-zsh/plugins/
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
    # Custom plugins
    zsh-autosuggestions
    zsh-syntax-highlighting
    autoupdate

    # Standard Plugins
    colorize
    colored-man-pages
    npm
    git
    nvm
    alias-finder
    z
    fzf
    fz
    ag
)

# Completion settings
COMPLETION_WAITING_DOTS="true"
ZSH_AUTOSUGGEST_STRATEGY=(completion match_prev_cmd history)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

ZSH_ALIAS_FINDER_AUTOMATIC="true"

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/.aliases

##### User configuration #####

export LANG=en_US.UTF-8
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export MANWIDTH=100

export PYTHONDONTWRITEBYTECODE=1

##### Mac-OS only #####

source ~/.iterm2_shell_integration.zsh
export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"

##### Ruby #####

source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh
chruby ruby-2.7.3

##### nvm #####

export NVM_DIR="$HOME/.nvm"
# Load nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# Load nvm completions
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
