# powerlevel10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to omz directory
export ZSH="/Users/pickle/.oh-my-zsh"

# Set omz theme
export ZSH_THEME="powerlevel10k/powerlevel10k"

# Set omz to update automatically
zstyle ":omz:update" mode auto

# Set omz update frequency in days
zstyle ":omz:update" frequency 1

# Show dots when waiting for completion
export COMPLETION_WAITING_DOTS=true

################################################################################
# Plugins ######################################################################
################################################################################

# Custom Plugin Settings #######################################################

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_STRATEGY=(completion match_prev_cmd history)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# autoupdate
export UPDATE_ZSH_DAYS=1

# zsh-nvm
export NVM_DIR="$HOME/.nvm"
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=("nvim" "ncu" "update" "clear", "brew")

# zsh-vi-mode
export ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
export ZVM_KEYTIMEOUT=0.3

# Standard Plugin Settings #####################################################

# colorize
export ZSH_COLORIZE_TOOL=chroma

# fzf
export FZF_DEFAULT_COMMAND='rg --no-ignore --hidden -l ""'
export FZF_CTRL_T_COMMAND='rg --no-ignore --hidden -l ""'
export FZF_ALT_C_COMMAND='rg --no-ignore --hidden -l ""'

# Plugins ######################################################################

# Standard plugins can be found in ~/.oh-my-zsh/plugins/
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
    # Custom plugins
    autoupdate
    zsh-autosuggestions
    fast-syntax-highlighting
    zsh-nvm
    zsh-vi-mode

    # Standard Plugins
    ag
    aliases # use 'acs' to search aliases
    colored-man-pages
    colorize
    cp
    fzf
    git
    gh
    iterm2
    macos
    npm
    nvm
    rust
    z
)

################################################################################
# omz settings #################################################################
################################################################################

# iterm2 shell integration
zstyle :omz:plugins:iterm2 shell-integration yes

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

################################################################################
# User configuration ###########################################################
################################################################################

# Set default language
export LANG=en_US.UTF-8

# Set visual and cmd line editors
export EDITOR="/usr/local/bin/nvim"
export VISUAL="/usr/local/bin/nvim"

# Set pager options
export PAGER="less"
export MANPAGER="nvim +Man!"
export MANWIDTH=80

# Export config dir
export XDG_CONFIG_HOME="$HOME/.config"

################################################################################
# Python #######################################################################
################################################################################

export PYTHONDONTWRITEBYTECODE=1

# Add homebrew python to path
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

################################################################################
# Java #########################################################################
################################################################################

# Set java version
export JAVA_HOME="$(/usr/libexec/java_home)"

export PATH="$JAVA_HOME/bin:$PATH"

################################################################################
# chruby #######################################################################
################################################################################

source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

# Set ruby version
chruby ruby-3.2.2

################################################################################
# Aliases ######################################################################
################################################################################

# Use eza for ls and l
alias ls="eza -F --icons --group-directories-first -a"
alias l="ls -l"

# Use colorized cat and less
alias cat="ccat"
alias less="cless -R -i"

# Open neovide
alias neo="neovide --frame=none --multigrid"

# Update everything
alias update="~/update"

################################################################################
# Other ########################################################################
################################################################################

# Time zsh startup time
timezsh() {
    shell=${1-$SHELL}
    for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# bun completions
[ -s "/Users/pickle/.bun/_bun" ] && source "/Users/pickle/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bob
fpath+=~/.zfunc
export PATH="/Users/pickle/.local/share/bob/nvim-bin:$PATH"

################################################################################

# Disable warning message at start
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# add doom emacs to path
export PATH="/Users/pickle/.emacs.d/bin:$PATH"

# eval "$(starship init zsh)"
