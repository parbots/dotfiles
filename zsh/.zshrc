#!/bin/zsh

# Start powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to omz directory
export ZSH="$HOME/.oh-my-zsh"

# Set omz theme
export ZSH_THEME="powerlevel10k/powerlevel10k"

# Set omz to update automatically
zstyle ":omz:update" mode auto

# Set omz update frequency in days
zstyle ":omz:update" frequency 1

# Show dots when waiting for completion
export COMPLETION_WAITING_DOTS=true

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_STRATEGY=(completion match_prev_cmd history)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# autoupdate
export UPDATE_ZSH_DAYS=1

# zsh-nvm
export NVM_DIR="$HOME/.nvm"
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=("nvim" "ncu" "update" "clear" "brew")

# zsh-vi-mode
export ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_NEX
export ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
export ZVM_KEYTIMEOUT=0.3

# colorize
export ZSH_COLORIZE_TOOL=chroma

# fzf
export FZF_DEFAULT_COMMAND='rg --no-ignore --hidden -l ""'
export FZF_CTRL_T_COMMAND='rg --no-ignore --hidden -l ""'
export FZF_ALT_C_COMMAND='rg --no-ignore --hidden -l ""'

# Standard plugins can be found in ~/.oh-my-zsh/plugins/
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
export plugins=(
    ag
    aliases # use 'acs' to search aliases
    autoupdate # Custom
    colored-man-pages
    colorize
    cp
    fast-syntax-highlighting # Custom
    fzf
    gh
    git
    macos
    npm
    nvm
    rust
    z
    zsh-autosuggestions # Custom
    zsh-nvm # Custom
    zsh-vi-mode # Custom
)

# Source oh-my-zsh
source "$ZSH/oh-my-zsh.sh"

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

# Make python better
export PYTHONDONTWRITEBYTECODE=1

# Add homebrew python to path
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# Set java version
export JAVA_HOME
JAVA_HOME=$(/usr/libexec/java_home)

# Add java to path
export PATH="$JAVA_HOME/bin:$PATH"

# Enable frum
eval "$(frum init)"

################################################################################
# Aliases ######################################################################
################################################################################

# Use eza for ls and l
alias ls="eza --grid --all --all --group-directories-first --icons=auto --color=auto --color-scale"
alias lsd="ls --only-dirs"
alias lsf="ls --only-files --long --header --binary --time-style=\"+%H:%M %m/%d/%Y\""
alias l="ls --long --header --time-style=\"+%H:%M %m/%d/%Y\" --no-filesize"

# Use colorized cat and less
alias cat="ccat"
alias less="cless -R -i"

# Open neovide
alias neo="neovide --frame=none --multigrid"

# Update everything
alias update="~/update"

# Source bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Add bun to path
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Add bob to path
fpath+=~/.zfunc
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

################################################################################

# eval "$(starship init zsh)"

bindkey -v

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source "$HOME/.p10k.zsh"
