#################
#### aliases ####
#################
alias emacs="/usr/local/Caskroom/emacs/27.1-1/Emacs.app/Contents/MacOS/Emacs -nw"
alias emacsgui="open -a emacs"
alias vim="mvim -v"
#alias nvim="~/1/nvim-osx64/bin/nvim"
alias vimdiff="nvim -d"
alias zathuraf="zathura --mode fullscreen"
alias jn="jupyter notebook"

# cd, then ls
cs() {
  cd "$1" && pwd && echo && ls;
}

export EDITOR="nvim"
export TERM="xterm-256color"
#export TERM="screen-256color"

#alias ls='ls -G'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# Tell ls to be colourful
export CLICOLOR=1
# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

#export PS1="\h:\W \u\$" # DEFAULT
export PS1="\n\n\w\n$ "

export PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"

# opam configuration
test -r /Users/ogelsir/.opam/opam-init/init.sh && . /Users/ogelsir/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/ogelsir/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/ogelsir/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/ogelsir/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/ogelsir/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

