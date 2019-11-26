if [[ $ZSH_DEBUG_PROMPT == 1 || $ZSH_DEBUG == 1 ]]; then
    echo "Entering dsh.zsh-theme"
fi

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'
local current_dir='%{$terminfo[bold]$fg[blue]%} %~%{$reset_color%}'
local git_branch='$(git_prompt_info)%{$reset_color%}'
local zsh_mode_text='$(zsh_mode_prompt_info)%{$reset_color%}'
local active_port_mode_text='$( zsh_prompt_port_selections )%{$reset_color%}'
local left1='$( left_prompt 1 )'
local left2='$( left_prompt 2 )'
local left3='$( left_prompt 3 )'

function left_prompt() {
    local to_echo
    case $1 in
        (1) to_echo="╓ " ;;
        (2) to_echo="╟"  ;;
        (3) to_echo="╙ " ;;
    esac

    if [[ $+SHOW_MONKEYS == 1 ]]; then
        case $1 in
            (1) to_echo="🙈  $to_echo" ;;
            (2) to_echo="🙉  $to_echo" ;;
            (3) to_echo="🙊  $to_echo" ;;
        esac
    fi

    # Find out where we are
    local LEFT_PROMPT_PREFIX
    local LEFT_PROMPT_SUFFIX="%{${reset_color}%}"

    case $( where-am-i) in
        (sandia_laptop*)      LEFT_PROMPT_PREFIX="%{${FG[088]}%}" ;;
        (warpcore)            LEFT_PROMPT_PREFIX="%{${FG[017]}%}" ;;
        (nersc*)              LEFT_PROMPT_PREFIX="%{${FG[028]}%}" ;;
        (*)                   LEFT_PROMPT_PREFIX="%{${FG[017]}%}" ;;
    esac

    echo $LEFT_PROMPT_PREFIX$to_echo$LEFT_PROMPT_SUFFIX
}

PROMPT="${left1}${user_host}${git_branch}${zsh_mode_text} ${active_port_mode_text}
${left2}${current_dir}
${left3}%B$%b "
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="›%{$reset_color%}"
ZSH_THEME_ZSH_MODE_PROMPT_PREFIX=" %{$fg[cyan]%}‹‹"
ZSH_THEME_ZSH_MODE_PROMPT_SUFFIX="››%{$reset_color%}"
typeset -AU ZSH_THEME_ACTIVE_PORT_PREFIX
typeset -AU ZSH_THEME_ACTIVE_PORT_SUFFIX
typeset -AU ZSH_THEME_ACTIVE_PORT_NAME_PRE
typeset -AU ZSH_THEME_ACTIVE_PORT_NAME_POST
ZSH_THEME_ACTIVE_PORT_NAME_PRE[mpi]='"$name: "'
ZSH_THEME_ACTIVE_PORT_PREFIX[mpi]="%{$FX[italic]$FG[105]%}➠ "
ZSH_THEME_ACTIVE_PORT_SUFFIX[mpi]="%{$reset_color%}"

ZSH_THEME_ACTIVE_PORT_NAME_PRE[python]='"$name "'
ZSH_THEME_ACTIVE_PORT_PREFIX[python]="%{$FX[underline]$FG[059]%}❰"
ZSH_THEME_ACTIVE_PORT_SUFFIX[python]="❱%{$reset_color%}"
ZSH_THEME_ACTIVE_PORT_PREFIX[ipython]="%{$FX[underline]$FG[151]%}❰"
ZSH_THEME_ACTIVE_PORT_SUFFIX[ipython]="❱%{$reset_color%}"

if [[ $ZSH_DEBUG_PROMPT == 1 || $ZSH_DEBUG == 1 ]]; then
    echo "Exiting dsh.zsh-theme"
fi

