# useful shortcuts:
# ^R - quicksearch thorugh bash history
# lst, lss, lsx, lsrt, lsrs, lsrx = ls -t, ls -S, ls -X, ls -r, - sort by timestamp/size/extension/reverse
# disown X - make job X not a child
# Alt+B, Alt+F jumps forward/back a word
# pkill/pgrep, iftop/tcptrack, iotop
# read man bash

[ -f /etc/profile ] && source /etc/profile

export MAILDIR="$HOME/.maildir"
unset MAIL
export PATH="$PATH:/sbin:/usr/sbin:/usr/local/sbin:/usr/local/bin:$HOME/bin:$HOME/bio-bin"
export PERL5LIB="$PERL5LIB:$HOME/lib/perl"
export R_LIBS_USER="${HOME}/lib/R"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${HOME}/lib

#[ $EUID == 0 ] || export PATH="$PATH:."

# cleaned up platform name
export PLATFORM="${OSTYPE//[0-9\.]}"

# Setup some colors to use later in interactive shell or scripts
export NC='\[\e[m\]' # No Color
export BLACK='\[\e[0;30m\]'
export GRAY='\[\e[1;30m\]'
export RED='\[\e[0;31m\]'
export LIGHT_RED='\[\e[1;31m\]'
export GREEN='\[\e[0;32m\]'
export LIGHT_GREEN='\[\e[1;32m\]'
export BROWN='\[\e[0;33m\]'
export YELLOW='\[\e[1;33m\]'
export BLUE='\[\e[0;34m\]'
export LIGHT_BLUE='\[\e[1;34m\]'
export PURPLE='\[\e[0;35m\]'
export LIGHT_PURPLE='\[\e[1;35m\]'
export CYAN='\[\e[0;36m\]'
export LIGHT_CYAN='\[\e[1;36m\]'
export LIGHT_GRAY='\[\e[0;37m\]'
export WHITE='\[\e[1;37m\]'

if [ $PLATFORM == "darwin" ]; then
    export GOPATH=$HOME/Code/go
    export CC=clang
    export CXX=clang
    export FFLAGS=-ff2c
    export CFLAGS=-Qunused-arguments
    export CPPFLAGS=-Qunused-arguments
fi

export PYTHON_EGG_CACHE="/tmp"
export GREP_OPTIONS="--color=auto"
export CLICOLOR=1

if [ "$PS1" ]; then
        PROMPT_COMMAND='history -a' #;history -n'
        [ -x /usr/bin/colordiff ] && alias diff='colordiff'
        [ -x /usr/bin/htop ] && alias top='htop'
        [ -x /usr/bin/pydf ] && alias df='pydf'
        [ -f /etc/profile.d/bash-completion ] && source /etc/profile.d/bash-completion
        [ -f /etc/bash_completion ] && source /etc/bash_completion
        export HISTCONTROL=ignoredups:ignorespace
        alias loggedin='who|cut -f 1 -d " "|sort|uniq'
        alias cd..='cd ..'
        alias grep='grep --color=auto'
    alias hi='history'
    alias j='jobs -l'
    alias ls='ls -h --color=auto'
    alias mv='mv -i'
    alias rn='rn -q'
    alias dir='ls -h --color=auto'
    alias move='mv'
    alias quit='exit'
    alias cls='clear'
    alias lsa='ls -lhA --color=auto'
        alias lss='ls -lhAS --color=auto' # size
        alias lsrs='ls -lhArS -h --color=auto'
        alias lst='ls -lhAt --color=auto' # date
        alias lsrt='ls -lhArt --color=auto'
        alias lsx='ls -lhAX --color=auto' # extension
        alias lsrx='ls -lhArX --color=auto'
    alias lr='ls -lR --color=auto' # recurse
        alias lsd='find . -maxdepth 1 -type d'
    alias psa='ps -Alfww --forest --headers|less'
        alias cp='cp -i'
        alias copy='cp -i'
    alias path='echo -e ${PATH//:/\\n}'
    alias du='du -h'
    alias tree='tree -Cs'
        alias makepatch='diff -u --ignore-space-change'
        alias hl='grep --color=yes --context=1000000'
        alias qdel_me='qstat|grep ${USER}|cut -f 1 -d " "|xargs qdel'
        alias check_md='cat /proc/mdstat; for i in store diamond onyx; do echo $i; ssh $i cat /proc/mdstat; done; sudo ssh store tw_cli show'

        alias archive_init='pushd ~/archive && git clone ssh://horizon/~/archive.git && popd'
        alias archive_push='pushd ~/archive && git commit --all -m "archive push" && git push ssh://horizon/~/archive.git master && popd'
        alias archive_pull='pushd ~/archive && git pull ssh://horizon/~/archive.git && popd'


# this is all very nice and wonderful but deathly slow
        C_BOLD=$(tput bold)
#       C_BLACK=$(tput setaf 0)
#       C_RED=$(tput setaf 1)
#       C_GREEN=$(tput setaf 2)
#       C_BROWN=$(tput setaf 3)
        C_BLUE=$(tput setaf 4)
#       C_PURPLE=$(tput setaf 5)
#       C_CYAN=$(tput setaf 6)
#       C_LIGHT_GREY=$(tput setaf 7)
#       C_DARK_GREY=$(tput bold; tput setaf 0)
        C_LIGHT_RED=$(tput bold; tput setaf 1)
#       C_LIGHT_GREEN=$(tput bold; tput setaf 2)
#       C_YELLOW=$(tput bold; tput setaf 3)
#       C_BRIGHT_BLUE=$(tput bold; tput setaf 4)
#       C_PINK=$(tput bold; tput setaf 5)
#       C_BRIGHT_CYAN=$(tput bold; tput setaf 6)
#       C_WHITE=$(tput bold; tput setaf 7)
#       C_BG_BLACK=$(tput setab 0)
#       C_BG_RED=$(tput setab 1)
#       C_BG_GREEN=$(tput setab 2)
#       C_BG_BROWN=$(tput setab 3)
#       C_BG_BLUE=$(tput setab 4)
#       C_BG_PURPLE=$(tput setab 5)
#       C_BG_CYAN=$(tput setab 6)
#       C_BG_LIGHT_GREY=$(tput setab 7)
        C_RESET=$(tput sgr0)
#       for i in ${!C_*}; do; done

        stty werase '^_' # set Ctrl+Backspace to delete prev word
        stty -ixon # disable flow control (ctrl+S/ctrl+Q)

        if [ $EUID == 0 ] ; then
                export PS1="\[$C_LIGHT_RED\]\u@\h\[$C_RESET\]\[$C_BOLD\]:\[$C_BLUE\]\w\[$C_RESET\]# "
        else

[ -f $HOME/.keychain/$HOSTNAME-sh ] && source $HOME/.keychain/$HOSTNAME-sh
[ -f /usr/local/bin/start-keychain ] && source /usr/local/bin/start-keychain
[ -f $HOME/bin/start-keychain ] && source $HOME/bin/start-keychain
[ -f $HOME/.sunriserc ] && source $HOME/.sunriserc

                export PS1="\[$C_LIGHT_RED\]\u@\h\[$C_RESET\]\[$C_BOLD\]:\[$C_BLUE\]\w\[$C_RESET\]\[$C_BOLD\]>\[$C_RESET\]"
                export HISTSIZE=80000
                export HISTFILESIZE=80000
                export HISTCONTROL="ignoredups"
                function ff() { find . -name '*'$1'*' ; }
                function fe() { find . -name '*'$1'*' -exec $2 {} \; ; }
                function fstr() { # find a string in a set of files
                        if [ "$#" -gt 2 ]; then
                                echo "Usage: fstr \"pattern\" [files] "
                                return;
                        fi
                        SMSO=$(tput smso)
                        RMSO=$(tput rmso)
                        find . -type f -name "${2:-*}" -print | xargs grep -sin "$1" | \
                                sed "s/$1/$SMSO$1$RMSO/gI"
                }
                function swap() {
                        local TMPFILE=tmp.$$
                        mv $1 $TMPFILE
                        mv $2 $1
                        mv $TMPFILE $2
                }

                shopt -s cdspell extglob dotglob histappend
                set visible-stats on
        fi
        echo -ne '\e]10;#839496\a'  # foreground
        echo -ne '\e]11;#002b36\a'  # background
        echo -ne '\e]12;#d33682\a'  # cursor
        echo -ne '\e]4;0;#586E75\a'   # black
        echo -ne '\e]4;1;#D30102\a'   # red
        echo -ne '\e]4;2;#859900\a'   # green
        echo -ne '\e]4;3;#B58900\a'   # yellow
        echo -ne '\e]4;4;#268BD2\a'   # blue
        echo -ne '\e]4;5;#D33682\a'   # magenta
        echo -ne '\e]4;6;#2aa198\a'   # cyan
        echo -ne '\e]4;7;#EEE8D5\a'   # white
        echo -ne '\e]4;8;#586E75\a'   # bold black
        echo -ne '\e]4;9;#CB4B16\a'   # bold red
        echo -ne '\e]4;10;#859900\a'  # bold green
        echo -ne '\e]4;11;#B58900\a'  # bold yellow
        echo -ne '\e]4;12;#268BD2\a'  # bold blue
        echo -ne '\e]4;13;#6C71C4\a'  # bold magenta
        echo -ne '\e]4;14;#2AA1A1\a'  # bold cyan
        echo -ne '\e]4;15;#fdf6e3\a'  # bold white
        
        # virtualenvwrapper
        export WORKON_HOME=$HOME/.virtualenvs
        VIRTUALENV_WRAPPER=/usr/local/bin/virtualenvwrapper.sh
        if [ -f $VIRTUALENV_WRAPPER ]; then
            source $VIRTUALENV_WRAPPER
        fi
        
        # bash completion
        if [[ -z brew && $(brew --prefix)/etc/bash_completion ]]; then
            . $(brew --prefix)/etc/bash_completion
        fi
        
        # load additional extras if available. this generally contains platform
        # specific components
        if [ -f $HOME/.bashrc-extras ]; then
            . $HOME/.bashrc-extras
        fi
        
        # convenience functions
        if [ -f $HOME/.functions ]; then
            . $HOME/.functions
        fi
fi
