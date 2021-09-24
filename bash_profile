
# added by Anaconda3 2019.07 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

# aliases
alias emacs="/usr/local/Caskroom/emacs/27.1-1/Emacs.app/Contents/MacOS/Emacs -nw"
alias emacsgui="open -a emacs"
alias vim="mvim -v"
alias zathuraf="zathura --mode fullscreen"

export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --border'

export EDITOR="vim"
export TERM="xterm-256color"

alias ls='ls -G'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export LS_COLORS='di=1;34:ln=1;35:so=1;32:pi=1;33:ex=1;31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

#export PS1="\h:\W \u\$" # DEFAULT
#export PS1="$ " # do not display anything before the "$" in terminal
export PS1="\w\n$ "
#export PROMPT_COMMAND="echo" # print new line after every command
#export PROMPT_COMMAND="printf '─%.0s' {1..$(tput cols)}" # print new line after every command

export RED=$(tput setaf 1 :-"" 2>/dev/null)
export GREEN=$(tput setaf 2 :-"" 2>/dev/null)
export YELLOW=$(tput setaf 3 :-"" 2>/dev/null)
export BLUE=$(tput setaf 4 :-"" 2>/dev/null)
export RESET=$(tput sgr0 :-"" 2>/dev/null)
function print_line() {
  # print a solid line with length equal to half of the columns on the screen
  # some help: https://stackoverflow.com/questions/42762643/draw-a-horizontal-line-from-dash-character-occupying-the-full-width-of-a-termina/42762743 
  printf $BLUE
  printf "%0.s─" $(seq 1 2 $(tput cols))
  printf $RESET
  echo
}
export PROMPT_COMMAND="eval print_line" 
bind -x '"\C-l": clear; eval print_line'

export PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"
