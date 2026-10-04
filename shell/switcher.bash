# switcher — `cd` rapide vers un projet, dans le shell courant.
# À sourcer depuis ~/.bashrc :  source /chemin/vers/switcher/shell/switcher.bash
#
#   p            choisir un projet avec fzf
#   p app        alias exact -> cd direct ; sinon fzf pré-filtré (cd direct si un seul résultat)

p() {
    local dir
    if [ $# -eq 1 ] && dir=$(switcher alias "$1" 2>/dev/null); then
        :
    else
        dir=$(switcher list --tsv | fzf --delimiter=$'\t' --with-nth=1 --tiebreak=index \
            --height=40% --reverse --prompt='projet> ' \
            --query="$*" --select-1 --exit-0) || return
        dir=${dir#*$'\t'}
    fi
    cd -- "$dir" && switcher touch "$dir"
}

_p_complete() {
    local IFS=$'\n'
    COMPREPLY=($(compgen -W "$(switcher list --aliases 2>/dev/null)" -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F _p_complete p
