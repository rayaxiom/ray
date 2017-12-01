# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias rrgrep='grep -rnI --exclude=tags --color=auto'
alias rrfgrep='fgrep -rnI --exclude=tags --color=auto'
alias rregrep='egrep -rnI --exclude=tags --color=auto'

# some more ls aliases
alias ll='ls -alFv'
alias la='ls -A'
alias l='ls -CF'

alias rrkillalljobs='kill -9 $(jobs -p)'

alias youtube-dl='youtube-dl --prefer-ffmpeg'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias matlabno='matlab -nojvm -nodisplay -nodesktop'
alias gvim='gvim -p'
export PATH=$PATH:/home/ray/ray/bin
source /home/ray/ray/dotfiles/.bashrc_alias

#kancolle_api_file="/home/ray/kancolle_api_file"
#kancolle_api=$(grep "mainD2" $kancolle_api_file)
#chromium_command="chromium-browser --disk-cache-size=1073741824 --disk-cache-dir=/home/ray/chromium_cache"
#alias kkl="nohup $chromium_command  \"$kancolle_api\" > /dev/null 2>&1 &"

export EDITOR=vim

#OOMPHDIR="/home/ray/oomphlib/mpi_debug_paranoid"
OOMPHDIR="/home/ray/oomphlib/trunk"
OOMPHDIRUDRI="$OOMPHDIR/user_drivers"
OOMPHOPT='/home/ray/oomphlib/mpi_optimized'
OOMPHOPTUDRI="$OOMPHOPT/user_drivers"


export PATH=$PATH:$OOMPHDIR/bin

rrtar()
{
  tar cvpzf ${1}.tar.gz ${1}
}

rrxtar()
{
  tar xpzf ${1}
}


get_oomph_git_info()
{
  CURRENT_DIR=`pwd`

  cd $OOMPHDIR && \
  git log -1 > $CURRENT_DIR/git_rev_revision && \
  cd $OOMPHDIRUDRI && \
  git log -1 > $CURRENT_DIR/git_rev_user_driver && \
  cd $CURRENT_DIR
}

synoomph()
{
  cd $OOMPHDIR && \
  git push --force origin master && \
  cd $OOMPHDIRUDRI && \
  git push --force origin master && \
  cd $OOMPHOPT && \
  git fetch --all && \
  git reset --hard origin/master && \
  cd $OOMPHOPTUDRI && \
  git fetch --all && \
  git reset --hard origin/master && \
  cd $OOMPHOPT && \
  ./autogen_quick.sh --rebuild --jobs=4 && \
  cd $OOMPHOPTUDRI
}

pushonly()
{
  local CURRENTDIR=`pwd`
  cd $OOMPHDIR && \
  git push --force origin master && \
  cd $OOMPHDIRUDRI && \
  git push --force origin master && \
  cd $CURRENTDIR
}

pullonly()
{
  local CURRENTDIR=`pwd`
  cd $OOMPHOPT && \
  git fetch --all && \
  git reset --hard origin/master && \
  cd $OOMPHOPTUDRI && \
  git fetch --all && \
  git reset --hard origin/master && \
  cd $CURRENTDIR
}

pponly()
{
  local CURRENTDIR=`pwd`
  cd $OOMPHDIR && \
  git push --force origin master && \
  cd $OOMPHDIRUDRI && \
  git push --force origin master && \
  cd $OOMPHOPT && \
  git fetch --all && \
  git reset --hard origin/master && \
  cd $OOMPHOPTUDRI && \
  git fetch --all && \
  git reset --hard origin/master && \
  cd $CURRENTDIR
}

gaac()
{
  git add -A && git commit && git push -u origin master
}


# Now we can set up the prompt

#PROMPT_COMMAND='history -a;echo -en "\033[m\033[38;5;2m"$(( `sed -nu "s/MemFree:[\t ]\+\([0-9]\+\) kB/\1/p" /proc/meminfo`/1024))"\033[38;5;22m/"$((`sed -nu "s/MemTotal:[\t ]\+\([0-9]\+\) kB/\1/Ip" /proc/meminfo`/1024 ))MB"\t\033[m\033[38;5;25m$(< /proc/loadavg)\033[m"'
#PS1='\[\e[m\n\e[1;30m\][\j:\!]\[\e[0;36m\] \t \d \[\e[1;30m\][\[\e[1;34m\]\u@\H\[\e[1;30m\]:\[\e[0;37m\]${SSH_TTY} \[\e[0;32m\]+${SHLVL}\[\e[1;30m\]] \[\e[1;37m\]\w\[\e[0;37m\] \n\$ '


PS1='\[\e[0;36m\]\t\[\e[1;30m\][\[\e[1;34m\]\u@\H\[\e[1;30m\]:\[\e[0;37m\]${SSH_TTY} \[\e[0;32m\]+${SHLVL}\[\e[1;30m\]] \[\e[1;37m\]\w\[\e[0;37m\] \n\$ '
# Git stuff from Dave S

#PS1="$PS1"'\[\033[1;36m\]$(gitbranch " (%s)")\[\033[0m\] \$\n '

function listalias()
{
  grep ${1} ~/ray/dotfiles/.bashrc_alias
}

function pdfpextr()
{
    # this function uses 3 arguments:
    #     $1 is the first page of the range to extract
    #     $2 is the last page of the range to extract
    #     $3 is the input file
    #     output file will be named "inputfile_pXX-pYY.pdf"
    gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
       -dFirstPage=${1} \
       -dLastPage=${2} \
       -sOutputFile=${3%.pdf}_p${1}-p${2}.pdf \
       ${3}
}


# Map Esc key to Caplocks.
#xmodmap -e "clear lock"
#xmodmap -e "keycode 0x42 = Escape"

# Undo the above.
#xmodmap -e "keycode 0x42 = Caps_Lock"
#xmodmap -e "add lock = Caps_Lock"

#[ -s ~/".scm_breeze/scm_breeze.sh" ] && source ~/".scm_breeze/scm_breeze.sh"

# When using make, errors are red, warnings are yellow
make()
{
  pathpat="^.*:[0-9]+"
  ccred=$(echo -e "\033[0;31m")
  ccyellow=$(echo -e "\033[0;33m")
  ccend=$(echo -e "\033[0m")
  /usr/bin/make "$@" 2>&1 | sed -E -e "/[Ee]rror[: ]/ s%$pathpat%$ccred&$ccend%g" -e "/[Ww]arning[: ]/ s%$pathpat%$ccyellow&$ccend%g"
  return ${PIPESTATUS[0]}
}
# This makes the function will be available at the shell prompt and also in 
# other scripts that you call from there
export -f make

## When using make, errors are red, warnings are yellow
#latexmk()
#{
#  pathpat="^.*:[0-9]+"
#  ccred=$(echo -e "\033[0;31m")
#  ccyellow=$(echo -e "\033[0;33m")
#  ccend=$(echo -e "\033[0m")
#                                   I can't get the below regex correct.
#  /usr/bin/latexmk "$@" 2>&1 | sed -E -e "/^\.[a-zA-Z0-9]+$/ s%$pathpat%$ccred&$ccend%g" -e "/[Ww]arning[: ]/ s%$pathpat%$ccyellow&$ccend%g"
#  return ${PIPESTATUS[0]}
#}
## This makes the function will be available at the shell prompt and also in 
## other scripts that you call from there
#export -f latexmk



# Opens new tab in current working directory
[[ -s "/etc/profile.d/vte.sh" ]] && . "/etc/profile.d/vte.sh"

grepstreamfunction()
{
  tail -n10000 -f $2 | grep --line-buffered "$1"
}
alias grepstream=grepstreamfunction

greptopfunction()
{
  top -b -d 10 | grep --line-buffered "$1"
}
alias greptop=greptopfunction


paraviewfunction()
{
  THISFILEBASE=${1%%.*} # Get rid of the extension
  OUTFILE="${THISFILEBASE}.vtu"
  source "$OOMPHDIR/bin/oomph-convert"
  oomph-convert $1
  paraview $OUTFILE
}


alias prv=paraviewfunction


