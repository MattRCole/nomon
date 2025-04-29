#!/bin/bash

_nomon_sh ()
{
    local cur prev opts base
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    all_long_opts="--ext --exec --watch --ignore --monitor --list-monitors -- --clear-screen --help "
    all_short_opts="-e -x -w -i -m -M -c -h "

    if [[ " ${COMP_WORDS[*]} " =~ [[:space:]]--[[:space:]] && "$cur" != '--' ]]; then
        # Stop completion when -- is found
        COMPREPLY=($(compgen -o dirnames -- $cur))
        return 0
    fi

    case $prev in
        -e|--ext)
            # Extensions to look for
            COMPREPLY=() # add your own logic here
            return 0
            ;;
        -x|--exec)
            # Execute arguments with executable
            COMPREPLY=($(compgen -c -- $cur))
            return 0
            ;;
        -w|--watch)
            # Watch directory or files
            COMPREPLY=($(compgen -o dirnames -- $cur))
            return 0
            ;;
        -i|--ignore)
            # Ignore the given regex pattern
            COMPREPLY=() # add your own logic here
            return 0
            ;;
        -m|--monitor)
            # Specify the fswatch monitor to use
            local availableMonitors="$(fswatch -M 2>/dev/null | tr -d ' ' | tr '\n' ' ')"
            if [ -n "$availableMonitors" ]
            then
                # local -a optArr
                # optArr=($availableMonitors)
                COMPREPLY=($(compgen -W "${availableMonitors}" -- $cur))
                # _values 'available monitors' ${(f)availableMonitors}
            else
                COMPREPLY=()
            fi
            return 0
            ;;
        *)
            case "$cur" in
                --*)
                    COMPREPLY=( $(compgen -W "${all_long_opts}" -- "${cur}") )
                    return 0
                    ;;
                -*)
                    COMPREPLY=( $(compgen -W "${all_short_opts}" -- "${cur}") )
                    return 0
                    ;;
                *)
                    COMPREPLY=( $(compgen -o bashdefault -o default -- "${cur}") )
                    return 0
                    ;;
            esac
    esac
}
complete -F _nomon_sh nomon.sh
