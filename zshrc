###########################################################
#                                                         # 
#   David Hollman's nice, clean, organized .zshrc file    #
#   With features copied/translated from my .tcshrc file  #
#   and a bunch of new stuff.                             #
#                                                         # 
#   Feel free to use anything you see and think would     #
#   be useful.  If you find some alias or something       #
#   useful, I'd appreciate it if you'd mention it to me   #
#   off-hand at some point, just because I'm curious      #
#   and I'm interested in how people use their shells     #
#   and zshrc files, and who's reading my zshrc file.     #
#   If that makes you uncomfortable, though, feel free    #
#   to browse, copy, steal, or plagerize anything you     #
#   see here in complete anonymity; really, I won't be    #
#   offended.  If you find any of my shortcuts or         #
#   tricks interesting, you might also want to browse     #
#   my ~/Scripts directory.                               #
#                                                         #
###########################################################


#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#   Stuff that should be at the beginning of the zsh file   {{{1
#-----------------------------------------------------------------------------------



#--Functions to be used later in this file------{{{2#
# Create a quick function for sourcing stuff only if it exists 
source_if_exists() {
    if [[ -e $1 ]]; then
        source $1
    fi
}
#-----------------------------------------------}}}2#
    

# Check if the ZSH_LOCAL variable is set.  If not, set it to $HOME/.zsh
if ((! $+ZSH_LOCAL)); then
    ZSH_LOCAL=$HOME/.zsh
fi


source_if_exists $ZSH_LOCAL/source_first.zsh


#--Compile stuff------------------------{{{2#
autoload -U zrecompile
zrecompile -p $ZSH_REPO/zshrc
if [[ -f $ZSH_REPO/zshrc.zwc.old ]]; then
    rm -f $ZSH_REPO/zshrc.zwc.old
fi
setopt NULL_GLOB
if [[ -d $ZSH_LOCAL/functions ]]; then
    for file in $ZSH_LOCAL/functions/**/*; do
        if [[ -f $file ]]; then
            zrecompile -p $file
            if [[ -f $file.zwc.old ]]; then
                rm -f $file.zwc.old
            fi
        fi
    done
fi

if [[ -d $ZSH_REPO/functions ]]; then
    for file in $ZSH_REPO/functions/**/*; do
        if [[ -f $file ]]; then
            zrecompile -p $file
            if [[ -f $file.zwc.old ]]; then
                rm -f $file.zwc.old
            fi
        fi
    done
fi

if [[ -d $ZSH_LOCAL ]]; then
    for file in $ZSH_LOCAL/**/*.zsh; do
        zrecompile -p $file
        if [[ -f $file.zwc.old ]]; then
            rm -f $file.zwc.old
        fi
    done;
fi
zrecompile -p $HOME/.zshrc
if [[ -f $HOME/.zshrc.zwc.old ]]; then
    rm -f $HOME/.zshrc.zwc.old
fi
unsetopt NULL_GLOB
#---------------------------------------}}}2#


# Necessary for checking to see if "unfunctioning" needs 
# to be done, among other things
zmodload zsh/parameter 2>/dev/null

# Need this...
setopt extended_glob

#}}}1
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#   Path variables   {{{1
#-----------------------------------------------------------------------------------


# path
source_if_exists $ZSH_LOCAL/paths/path.zsh

# Repo fpath directory; local function directories override this
fpath=($ZSH_REPO/functions $fpath)
#--Autoload zsh_repo functions--------------------{{{2
for file in $ZSH_REPO/functions/*; do
    funcname=`basename $file`
    if (( $+functions[$funcname] )); then
        unfunction $funcname
    fi
    autoload -U `basename $file`
done
#-------------------------------------------------}}}2

# fpath
source_if_exists $ZSH_LOCAL/paths/fpath.zsh

#--machine independent fpath variable-------------{{{2#
if [[ -d $ZSH_LOCAL/functions ]]; then
    fpath=($ZSH_LOCAL/functions $fpath)
    # Autoload everything in zsh_local
    source_if_exists $ZSH_LOCAL/autoload_functions.zsh
    for file in $ZSH_LOCAL/functions/*~*.zwc; do
        funcname=`basename $file`
        if (( $+functions[$funcname] )); then
            unfunction $funcname
        fi
        autoload -U `basename $file`
    done
fi
#-------------------------------------------------}}}2#

source_if_exists $ZSH_LOCAL/paths/manpath.zsh

source_if_exists $ZSH_LOCAL/paths/pythonpath.zsh

# Make sure we don't add too many things to the path arrays that we're adding stuff to
typeset -U path
typeset -U fpath
typeset -U manpath
#typeset -U PYTHONPATH
typeset -U pythonpath

#}}}1
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#   Random settings   {{{1
#-----------------------------------------------------------------------------------

# Export without using the word export
setopt all_export

# Vim forever...
EDITOR="/usr/bin/vim"

zstyle :compinstall filename "$HOME/.zshrc"

#--History file--------------------------{{{2#
HISTFILE=~/.histfile
# number of lines kept in history
HISTSIZE=10000
# number of lines saved in the history after logout
SAVEHIST=10000 
#-----------------------------------------}}}2#

# Stay compatible to sh and IFS
setopt SH_WORD_SPLIT

# csh-like redirection
setopt CLOBBER

# If a pattern for filename generation has no matches, delete the pattern from the argument list; do not report an error unless all the patterns in a
# command have no matches.  Overrides NOMATCH.
setopt CSH_NULL_GLOB

#--Pretty colors --------------------------{{{2#
autoload colors; colors;
# Unix/Linux version for autocomplete
export LS_COLORS='no=00:fi=00:di=01;36:ln=01;37;46:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.flac=01;35:*.mp3=01;35:*.mpc=01;35:*.ogg=01;35:*.wav=01;35:*.mp4=01;35'
#------------------------------------------}}}2#

#--rvm related--------------------------{{{2#
if [ -e $HOME/.rvm ]; then
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session
else
    function rvm-prompt() {
        # do nothing
    }
fi
#---------------------------------------}}}2#

#}}}1
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#   Modules to load that don't belong elsewhere   {{{1
#-----------------------------------------------------------------------------------
autoload -U zmv
autoload zargs
#}}}1
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#   Environment variables that don't belong elsewhere  {{{1
#-----------------------------------------------------------------------------------
if [[ -e $HOME/.pythonrc.py ]]; then
    PYTHONSTARTUP=$HOME/.pythonrc.py
fi

source_if_exists $ZSH_LOCAL/environment.zsh

WORKON_HOME=$HOME/.virtualenvs


#}}}1
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#   Oh-my-zsh {{{1
#-----------------------------------------------------------------------------------
if (( ! $+NO_OH_MY_ZSH )); then
    export ZSH=$ZSH_REPO/oh-my-zsh
    if [ -e ~/.zsh/oh-my-zsh-plugins.zsh ]; then
        source ~/.zsh/oh-my-zsh-plugins.zsh
    fi
    if (( ! $+ZSH_THEME )); then
        ZSH_THEME="bira"
    fi
    export COMPLETION_WAITING_DOTS="true"
    source $ZSH/oh-my-zsh.sh
fi

#--Undo/change things I don't like about oh-my-zsh--{{{2
unalias ..
export GREP_COLOR='1;36'
unsetopt auto_cd
zstyle '*' single-ignored no
unalias gm

# No correction!
unsetopt correct_all

#---------------------------------------------------}}}2

#}}}1
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#   Functions   {{{1
#-----------------------------------------------------------------------------------

div() { 
    for i in {1..$1}; print "$fg_bold[cyan]${(l.((${COLUMNS}))..─.)}$reset_color" 
}


run-fg() {
    zle push-input
    BUFFER="fg %"
    zle accept-line
}
zle -N run-fg


#--Opening files quickly with vim---------{{{2#
function viw() { vi `which $1` }
function visp() { vim $2 "+sp $1" }
function vispp() { vim $3 "+sp $2" "+sp $1" }
function visppp() { vim $4 "+sp $3" "+sp $2" "+sp $1" }
function vivsp() { vim $2 "+vsp $1" }
function vivspp() { vim $3 "+vsp $2" "+vsp $1" }
function vivsppp() { vim $4 "+vsp $3" "+vsp $2" "+vsp $1" }
#-----------------------------------------}}}2#


# Push changes to zshrc and such
pushp() {
    current_dir=`pwd`
    cd $ZSH_REPO
    git add .
    if [[ ${#ARGV} == 0 ]]; then
        git commit
    else
        git commit -m "$*"
    fi
    git pull # Pull in remote changes before pushing
    git push
    cd $current_dir
}
alias pushrc=pushp

    
pullp() {
    current_dir=`pwd`
    cd $ZSH_REPO
    git pull
    cd $current_dir
}
alias pullrc=pullp

#TODO syncp


#}}}1
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#   Key Bindings   {{{1
#-----------------------------------------------------------------------------------
##
# put ALT-. back to the way I like it
bindkey '\e.' insert-last-word
##
# Completion help :: useful for coming up with those completion context strings
bindkey '^Xh' _complete_help
##
# Menu selection :: pick multiple items in menu
bindkey -M menuselect '\C-^M' accept-and-menu-complete
##
# run-fg :: Forgrounds the most recent backgrounded process
bindkey '\e^Z' run-fg
##
# Vi mode
bindkey -v
##
# Fix vi's backspace to allow it to go past the insertion point
bindkey -M viins '' backward-delete-char
##
# History search
bindkey -M viins '^r'   history-incremental-search-backward
#bindkey -M vicmd '^r'   history-incremental-search-backward
bindkey -M viins '^k'   history-search-backward
bindkey -M vicmd '^k'   history-search-backward
bindkey -M vicmd 'k'    up-line-or-history
bindkey -M viins '^j'   history-search-forward
bindkey -M vicmd '^j'   history-search-forward
bindkey -M vicmd 'j'    down-line-or-history
bindkey -M viins '\e' accept-and-infer-next-history
##
# Spelling correction, because I can...
bindkey -M vicmd 'z=' spell-word
##
# Fix the stupid undo to be vim like instead of vi like
#bindkey -M vicmd 'u' undo
# The vi undo keeps the cursor in the same place, even if it does only go back 1
bindkey -M vicmd 'u' vi-undo-change
##
# Yank to end of line
bindkey -M vicmd 'Y' vi-yank-eol
##
# Fix the behavior of the home key
bindkey -M vicmd '' vi-beginning-of-line
bindkey -M viins '' vi-beginning-of-line
bindkey -M vicmd '' vi-end-of-line
bindkey -M viins '' vi-end-of-line
#}}}1
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#   Tab completion configuration   {{{1
#-----------------------------------------------------------------------------------
# Don't fill in first option
setopt list_ambiguous
setopt auto_list
setopt always_to_end

# General completion system configuration
# Don't do this if using oh-my-zsh
if (( $+NO_OH_MY_ZSH )); then
    zmodload zsh/complist
    autoload -U compinit
    compinit
fi

# Undo menuselect actions
bindkey -M menuselect '^[' undo

# Use a cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Add colors to completion
export ZLSCOLORS="${LS_COLORS}"
zstyle ':completion:*' completer _complete _list _approximate _list _expand
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31' 

if [ "x$COMPLETION_WAITING_DOTS" = "xtrue" ]; then
  complete-word-with-dots() {
    echo -n "\e[31m......\e[0m"
    zle complete-word
    zle redisplay
  }
  zle -N complete-word-with-dots
  bindkey "^I" complete-word-with-dots
fi



# No binary files for vi and friends
local binary_exts='*.(o|lo|gcno|zwc|gcda|a|la|dylib|so|aux|dvi|swp|fig|bbl|blg|bst|idx|ind|toc|class|pdf|ps|pyc)'
zstyle ':completion:*:*:vi:*:all-files' ignored-patterns $binary_exts
zstyle ':completion:*:*:vim:*:all-files' ignored-patterns $binary_exts
zstyle ':completion:*:*:gvim:*:all-files' ignored-patterns $binary_exts
zstyle ':completion:*:*:less:*' ignored-patterns $binary_exts
zstyle ':completion:*:*:zless:*' ignored-patterns $binary_exts

# Hosts completion
# oh-my-zsh does an abismal job of this, so fix it
myhosts=()
if [ -r /etc/ssh/ssh_known_hosts ]; then
    myhosts=($myhosts `awk '{print $1}' /etc/ssh/ssh_known_hosts | sed -e 's/,.*::.*:.*:.*:.*$//' -e 's/ssh-rsa//' | tr ',' '\n'`)
fi
if [ -r /var/lib/misc/ssh_known_hosts ]; then
    myhosts=($myhosts `awk '{print $1}' /var/lib/misc/ssh_known_hosts | sed -e 's/,.*::.*:.*:.*:.*$//' -e 's/ssh-rsa//' | tr ',' '\n'`)
fi
if [ -r $HOME/.ssh/known_hosts ]; then
    myhosts=($myhosts `awk '{print $1}' ~/.ssh/known_hosts | sed -e 's/,.*::.*:.*:.*:.*$//' -e 's/ssh-rsa//' | tr ',' '\n'`)
fi
if [ "$myhosts" ]; then
    typeset -U myhosts
    zstyle ':completion:*:hosts' hosts $myhosts
fi

# Get host-aliases from $HOME/.ssh/config
# These should already be in the known_hosts file somewhere...
#if [ -r $HOME/.ssh/config ]; then
#    hostfake=(`grep "^Host " $HOME/.ssh/config | sed 's/Host\ \(.*\)/\1:ssh-host-aliases/' | egrep -v '^\*$'`)
#    # As far as I know, only ssh and scp can use .ssh/config host-aliases
#    zstyle ':completion::complete:ssh:*:hosts' fake "$hostfake[@]"
#fi

# My own preference when it comes to the tcsh "complete=enhance" analog
zstyle ':completion:*:complete:*' matcher-list 'm:{a-z}={A-Z} m:[-._]=[-._]'


#zmodload -a colors
#zmodload -a autocomplete
# Group matches and Describe
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
#zstyle ':completion:*:*:kill:*' menu yes select
#zstyle ':completion:*:processes' command 'ps -au$USER'
#zstyle ':completion:*:default' list-colors yes
#}}}1
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#  Aliases  {{{1
#-----------------------------------------------------------------------------------

# Only aliases not specific to the current machine!

alias dv='print "$fg_bold[cyan]${(l.((${COLUMNS}-3))..─.)}$reset_color$fg_bold[cyan]───$reset_color"'
alias pgrep="grep -P"

#--Opening files quickly with vim---------{{{2#
alias vip="vi $ZSH_REPO/zshrc && source ~/.zshrc && echo 'Sourcing ~/.zshrc' "
alias virc="vi $ZSH_REPO/zshrc && source ~/.zshrc && echo 'Sourcing ~/.zshrc' "
alias vio='vi output.dat'
alias vii='vi input.dat'
alias viv='vi ~/.vimrc'
alias viro='vim -R'
alias vimro="vim -R"
alias vs='vim -S *.vimsession'
#-----------------------------------------}}}2#

alias tfo='tail -n 1000 -f output.dat'
alias tf="tail -n 1000 -f "
alias random='od -An -N2 -i /dev/urandom'
alias sop="source ~/.zshrc"
alias sorc="source /etc/csh.cshrc && source /etc/csh.login && source ~/.zshrc"
alias info='info $1 | less'
alias aliascd='cdalias'
alias c="clear"
alias mmv='noglob zmv -W'
alias gpush='git commit -a -m "`date` quick push using the gpush alias.  (Probably means I have not done anything worth talking about since the last commit, but I need to push quickly; or, it could just be laziness)" && git push'
alias gpushp='pushp "`date` quick push using the gpush alias.  (Probably means I have not done anything worth talking about since the last commit, but I need to push quickly; or, it could just be laziness)"'


# The rest of the aliases go in these files...

source_if_exists $HOME/.zsh/aliases.zsh

if [ -d $HOME/.zsh/working_environments ]; then
    for f in $HOME/.zsh/working_environments/**/*; do
        directory=`dirname $f`
        if [ -e $directory/.before.zsh ]; then
            if [ -e $directory/.after.zsh ]; then
                alias `basename $f .zsh`="source $directory/.before.zsh; source $f; source $directory/.after.zsh; "
            else
                alias `basename $f .zsh`="source $directory/.before.zsh; source $f"
            fi
        elif [ -e $directory/.after.zsh ]; then
            alias `basename $f .zsh`="source $f; source $directory/.after.zsh; "
        else
            alias `basename $f .zsh`="source $f"
        fi
    done
fi
#}}}1
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#   Hash directories   {{{1
#-----------------------------------------------------------------------------------
hash -d ZSH_LOCAL="$ZSH_LOCAL"
if [[ -d $ZSH_LOCAL/functions ]]; then
    hash -d ZSH_FUNCTIONS="$ZSH_LOCAL/functions"
fi
source_if_exists $ZSH_LOCAL/hash_directories.zsh
#}}}1
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#  Stuff that claims it needs to be at the end  {{{1
#-----------------------------------------------------------------------------------
if [ -e $HOME/.zsh/source_last.zsh ]; then
    source $HOME/.zsh/source_last.zsh
fi
# zsh syntax highlighting:
if ((! $+DISABLE_ZSH_HIGHLIGHTING)); then
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)
    source $ZSH_REPO/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    # All of this stuff has to go AFTER the above statement...
    # ZSH highlight styles
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=magenta'
    ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=magenta,bold'
    ZSH_HIGHLIGHT_STYLES[alias]='fg=green'
    ZSH_HIGHLIGHT_STYLES[builtin]='fg=green'
    ZSH_HIGHLIGHT_STYLES[function]='fg=green'
    ZSH_HIGHLIGHT_STYLES[command]='fg=green'
    ZSH_HIGHLIGHT_STYLES[precommand]='fg=yellow,underline'
    ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=white,bold,bg=red'
    ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='bold,bg=white'
    ZSH_HIGHLIGHT_STYLES[assign]='fg=yellow,bold'
    ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=yellow,bold'
    #
fi

# make sure we don't add too many things to arrays that we're adding stuff to
typeset -U fpath
typeset -U path

#}}}1
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
