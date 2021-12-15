alias python='python3'
alias gwip="git add --all && git commit -m 'WIP'"
alias gco='() { git checkout $1; }'
alias dv='devbox.py'

plugins=(z git zsh-autosuggestions)

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$HOME/git/cloud-dev:/opt/mssql-tools/bin:$PATH
