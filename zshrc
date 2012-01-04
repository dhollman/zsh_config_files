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
autoload -U zrecompile
zrecompile $HOME/.zshrc
#}}}1
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#   Path variables   {{{1
#-----------------------------------------------------------------------------------
if [[ -e $HOME/.zsh/paths/path.zsh ]] {
    source $HOME/.zsh/paths/path.zsh
}

#--fpath variable--------------------------{{{2#
fpath=($HOME/.zsh/functions $fpath)
#------------------------------------------}}}2#

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
setopt sh_word_split
#
# csh-like redirection
setopt clobber

#--Pretty colors --------------------------{{{2#
autoload colors; colors;
# Unix/Linux version for autocomplete
export LS_COLORS='no=00:fi=00:di=01;36:ln=01;37;46:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.flac=01;35:*.mp3=01;35:*.mpc=01;35:*.ogg=01;35:*.wav=01;35:*.mp4=01;35'
#------------------------------------------}}}2#

#--rvm related--------------------------{{{2#
if [ -e $HOME/.rvm ]; then
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session
fi
#---------------------------------------}}}2#

#}}}1
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#   Modules to load that don't belong elsewhere   {{{1
#-----------------------------------------------------------------------------------
autoload -U zmv
#}}}1
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#   Environment variables that don't belong elsewhere  {{{1
#-----------------------------------------------------------------------------------
if [ -e $HOME/.zsh/environment.zsh ]; then
    source $HOME/.zsh/environment.zsh
fi
#}}}1
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#   Oh-my-zsh {{{1
#-----------------------------------------------------------------------------------
if [[ ! -n "${NO_OH_MY_ZSH}" ]] then
    export ZSH=$ZSH_REPO/oh-my-zsh
    if [ -e ~/.zsh/oh-my-zsh-plugins.zsh ]; then
        source ~/.zsh/oh-my-zsh-plugins.zsh
    fi
    ZSH_THEME="bira"
    export COMPLETION_WAITING_DOTS="true"
    source $ZSH/oh-my-zsh.sh
fi

#--Undo/change things I don't like about oh-my-zsh--{{{2
unalias ..
export GREP_COLOR='1;36'
unsetopt auto_cd
bindkey '\e.' insert-last-word
#---------------------------------------------------}}}2

#}}}1
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#   Functions   {{{1
#-----------------------------------------------------------------------------------
div() { 
    for i in {1..$1}; print "$fg_bold[cyan]${(l.((${COLUMNS}))..─.)}$reset_color" 
}


run-fg-editor() {
    zle push-input
    BUFFER="fg %vi"
    zle accept-line
}
zle -N run-fg-editor


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
    if [[ $*[$#] = 0 ]]; then
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
# Completion help :: useful for coming up with those completion context strings
bindkey '^Xh' _complete_help
##
# Menu selection :: pick multiple items in menu
bindkey -M menuselect '\C-^M' accept-and-menu-complete
##
# run-fg-editor :: Forgrounds the editor
bindkey '\e^Z' run-fg-editor
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
#zmodload zsh/complist
#autoload -U compinit
#compinit

# Use a cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Add colors to completion
export ZLSCOLORS="${LS_COLORS}"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31' 

# no binary files for vi
local binary_exts='*.(o|lo|gcno|gcda|a|so|aux|dvi|log|swp|fig|bbl|blg|bst|idx|ind|out|toc|class|pdf|ps|pyc)'
zstyle ':completion:*:*:vi:*:all-files' ignored-patterns $binary_exts
zstyle ':completion:*:*:vim:*:all-files' ignored-patterns $binary_exts
zstyle ':completion:*:*:gvim:*:all-files' ignored-patterns $binary_exts
zstyle ':completion:*:*:less:*' ignored-patterns $binary_exts
zstyle ':completion:*:*:zless:*' ignored-patterns $binary_exts

# Hosts completion
# Already done by oh-my-zsh
#if [ -f ~/.ssh/known_hosts ]; then
#    hosts=(`awk '{print $1}' ~/.ssh/known_hosts | tr ',' '\n' `)
#fi
#if [ -f ~/.ssh/config ]; then
#    hosts=($hosts `grep ^Host ~/.ssh/config | sed s/Host\ // | egrep -v '^\*$'`)
#fi
#if [ -f /var/lib/misc/ssh_known_hosts ]; then
#    hosts=($hosts `awk -F "[, ]" '{print $1}' /var/lib/misc/ssh_known_hosts | sort -u`)
#fi
#if [ "$hosts" ]; then
#    zstyle ':completion:*:hosts' hosts $hosts
#fi

# My own preference when it comes to the tcsh "complete=enhance" analog
zstyle ':completion:*:complete:*' matcher-list 'm:{a-z}={A-Z} m:[-._]=[-._]'


#zmodload -a colors
#zmodload -a autocomplete
# Equivalent of tcsh "set complete=enhance"
# Group matches and Describe
#zstyle ':completion:*:matches' group 'yes'
#zstyle ':completion:*:options' description 'yes'
#zstyle ':completion:*:options' auto-description '%d'
#zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
#zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
#zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
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
alias vimro="vim -R"
alias vs='vim -S *.vimsession'
#-----------------------------------------}}}2#

alias tfo='tail -n 1000 -f output.dat'
alias tf="tail -n 1000 -f "
alias random='od -An -N2 -i /dev/urandom'
alias sop="source ~/.zshrc"
alias sorc="source /etc/csh.cshrc && source /etc/csh.login && source ~/.zshrc"
alias info='info $1 | less'
alias aliascd='aliasadd -p "cd Aliases" $1 cd `pwd`'
alias c="clear"
alias mmv='noglob zmv -W'
alias gpush='git commit -a -m "`date` quick push using the gpush alias.  (Probably means I have not done anything worth talking about since the last commit, but I need to push quickly; or, it could just be laziness)" && git push'
alias gpushp='pushp "`date` quick push using the gpush alias.  (Probably means I have not done anything worth talking about since the last commit, but I need to push quickly; or, it could just be laziness)"'

# The rest of the aliases go in these files...

if [ -e $HOME/.zsh/aliases.zsh ]; then
    source $HOME/.zsh/aliases.zsh
fi

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
if [ -e $HOME/.zsh/hash_directories.zsh ]; then
    source $HOME/.zsh/hash_directories.zsh
fi
#}}}1
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#  Stuff that claims it needs to be at the end  {{{1
#-----------------------------------------------------------------------------------
# Enable autojump
# TODO put this in some local file since it contains a non-relative path
export FPATH="$FPATH:/opt/local/share/zsh/site-functions/"
if [ -f /opt/local/etc/profile.d/autojump.sh ]; then
    . /opt/local/etc/profile.d/autojump.sh
fi
# zsh syntax highlighting:
if [[ ENABLE_ZSH_HIGHLIGHTING != false ]]; then
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
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
#}}}1
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
