#!/usr/bin/env zsh

local -A opts

# initialize the submodules
git submodule init
git submodule update

if [[ ! -e ${0:h}/oh-my-zsh/custom/themes/bira-mod.zsh-theme ]]; then
    echo "Linking theme file"
    mkdir -p ${0:h}/oh-my-zsh/custom/themes
    ln -s custom/bira-mod.zsh-theme ${0:h}/oh-my-zsh/custom/themes/bira-mod.zsh-theme
fi

# Parse arguments
zparseopts -A opts \
    -zsh-local: \
    -zshrc:

# Figure out what the ZSH_LOCAL directory is going to be.
local zshloc=${opts[--zsh-local]:-$HOME/.zsh}
if [[ ! -e $zshloc ]]; then
    mkdir -p $zshloc
fi

# Set up the path directories using the path helper if available, otherwise use environment variables
if [[ -x /usr/libexec/path_helper ]]; then
    eval `/usr/libexec/path_helper -s`
fi

if [[ ! -e $zshloc/paths ]]; then
    mkdir $zshloc/paths
fi

if [[ ! -e $zshloc/paths/path.zsh ]]; then
    echo "Setting up local \$PATH in $zshloc/paths/manpath.zsh"
    echo "##############" >> $zshloc/paths/path.zsh
    echo "# Local path #" >> $zshloc/paths/path.zsh
    echo "##############" >> $zshloc/paths/path.zsh
    echo "" >> $zshloc/paths/path.zsh
    foreach part ( ${=PATH//:/ } )
        echo "path=( \$path $part )" >> $zshloc/paths/path.zsh
    end
fi

if [[ ! -e $zshloc/paths/manpath.zsh ]]; then
    echo "Setting up local \$MANPATH in $zshloc/paths/manpath.zsh"
    echo "#################" >> $zshloc/paths/manpath.zsh
    echo "# Local manpath #" >> $zshloc/paths/manpath.zsh
    echo "#################" >> $zshloc/paths/manpath.zsh
    echo "" >> $zshloc/paths/manpath.zsh
    foreach part ( ${=MANPATH//:/ } )
        echo "path=( \$path $part )" >> $zshloc/paths/manpath.zsh
    end
fi


# Deploy the local zshrc
local zshrepo=${0:A:h}
local zshrcloc=${opts[--zshrc]:-$HOME/.zshrc}
if [[ ! -e $zshrcloc ]]; then
    echo "Deploying local .zshrc file in $zshrcloc"
    sed -e "s@%ZSH_REPO_LOC%@${(q)zshrepo}@g" \
            -e "s@%ZSH_LOCAL_LOC%@${(q)zshloc}@g" \
            < $zshrepo/zshrc.local.in > $zshrcloc
fi


# Deploy other zsh local directory files
function __deploy() {
    if [[ ! -e $zshloc/$1 ]]; then
        echo "Deploying $1 to $zshloc"
        cp $zshrepo/zsh_local_templates/$1 $zshloc/$1
    fi
}

__deploy aliases.zsh
__deploy environment.zsh
__deploy oh-my-zsh-plugins.zsh
__deploy source_last.zsh

