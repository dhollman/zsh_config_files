local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'
local current_dir='%{$terminfo[bold]$fg[blue]%} %~%{$reset_color%}'
local git_branch='$(git_prompt_info)%{$reset_color%}'
local zsh_mode_text='$(zsh_mode_prompt_info)%{$reset_color%}'
local mpi_mode_text='$(mpi_prompt_info)%{$reset_color%}'
local left1='$(left_prompt_1)'
local left2='$(left_prompt_2)'
local left3='$(left_prompt_3)'

local LEFT_PROMPT_PREFIX="%{${FG[088]}%}"
local LEFT_PROMPT_SUFFIX="%{${reset_color}%}"

function left_prompt_1() {
    local char
    if [[ $+SHOW_MONKEYS == 1 ]]; then
        char="🙈  "
    else
        char="╓ "
    fi
    echo $LEFT_PROMPT_PREFIX$char$LEFT_PROMPT_SUFFIX
}

function left_prompt_2() {
    local char
    if [[ $+SHOW_MONKEYS == 1 ]]; then
        char="🙉  "
    else
        char="╟"
    fi
    echo $LEFT_PROMPT_PREFIX$char$LEFT_PROMPT_SUFFIX
}

function left_prompt_3() {
    local char
    if [[ $+SHOW_MONKEYS == 1 ]]; then
        char="🙊  "
    else
        char="╙ "
    fi
    echo $LEFT_PROMPT_PREFIX$char$LEFT_PROMPT_SUFFIX
}

PROMPT="${left1}${user_host}${git_branch}${zsh_mode_text}${mpi_mode_text}
${left2}${current_dir}
${left3}%B$%b "
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="›%{$reset_color%}"
ZSH_THEME_ZSH_MODE_PROMPT_PREFIX=" %{$fg[cyan]%}‹‹"
ZSH_THEME_ZSH_MODE_PROMPT_SUFFIX="››%{$reset_color%}"
ZSH_THEME_MPI_PROMPT_PREFIX=" %{$FX[italic]$FG[105]%}➠ "
ZSH_THEME_MPI_PROMPT_SUFFIX="%{$reset_color%}"
