#! /usr/bin/env bash

scriptDir="$(dirname "$0")"
sourceDir="$(realpath "$scriptDir/../source")"

test "$__prereq_check_source" != "sourced" && source "${sourceDir}/__prereq-check.source"
test "$__escape_source" != "sourced" && source "${sourceDir}/__escape.source"

# ARG_OPTIONAL_REPEATED([ext],[e],[extensions to look for, ie. js. use once for each extension to watch])
# ARG_OPTIONAL_SINGLE([exec],[x],[execute arguments with executable, ie, -x "python -v"],[sh -c])
# ARG_OPTIONAL_REPEATED([watch],[w],[watch directory or files. use once for each directory or file to watch])
# ARG_OPTIONAL_REPEATED([ignore],[i],[ignore the given regex pattern. use once for each pattern you would like to ignore])
# ARG_OPTIONAL_SINGLE([monitor],[m],[Specify the fswatch monitor to use. Use the --list-monitors (-M) flag to list all available fswatch monitors])
# ARG_OPTIONAL_BOOLEAN([list-monitors],[M],[List all available fswatch monitors and exit. See 'https://github.com/emcrisostomo/fswatch/wiki' for more information on each monitor and what it does])
# ARG_OPTIONAL_SINGLE([REPLACEME],[],[to tell nomon.sh stop slurping arguments, any arguments after this will be passed as arguments to the program you stipulated])
# ARG_OPTIONAL_BOOLEAN([clear-screen],[c],[clear the screen between each run])
# ARG_POSITIONAL_INF([arguments],[to be passed to the specified executable (set with the --exec argument)],[0])
# ARG_HELP([Watch for file changes and execute a program whenever changes are detected])
# ARGBASH_GO()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.9.0 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info
# Generated online by https://argbash.io/generate


die()
{
    local _ret="${2:-1}"
    test "${_PRINT_HELP:-no}" = yes && print_help >&2
    echo "$1" >&2
    exit "${_ret}"
}


begins_with_short_option()
{
    local first_option all_short_options='exwimMch'
    first_option="${1:0:1}"
    test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - POSITIONALS
_positionals=()
_arg_arguments=()
# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_ext=()
_arg_exec="sh -c"
_arg_watch=()
_arg_ignore=()
_arg_monitor=
_arg_list_monitors="off"
_arg_replaceme=
_arg_clear_screen="off"


print_help()
{
    printf '%s\n' "Watch for file changes and execute a program whenever changes are detected"
    printf 'Usage: %s [-e|--ext <arg>] [-x|--exec <arg>] [-w|--watch <arg>] [-i|--ignore <arg>] [-m|--monitor <arg>] [-M|--(no-)list-monitors] [--REPLACEME <arg>] [-c|--(no-)clear-screen] [-h|--help] [<arguments-1>] ... [<arguments-n>] ...\n' "nomon.sh"
    printf '\t%s\n' "<arguments>: to be passed to the specified executable (set with the --exec argument)"
    printf '\t%s\n' "-e, --ext: extensions to look for, ie. js. use once for each extension to watch (empty by default)"
    printf '\t%s\n' "-x, --exec: execute arguments with executable, ie, -x \"python -v\" (default: 'sh -c')"
    printf '\t%s\n' "-w, --watch: watch directory or files. use once for each directory or file to watch (empty by default)"
    printf '\t%s\n' "-i, --ignore: ignore the given regex pattern. use once for each pattern you would like to ignore (empty by default)"
    printf '\t%s\n' "-m, --monitor: Specify the fswatch monitor to use. Use the --list-monitors (-M) flag to list all available fswatch monitors (let fswatch choose by default)"
    printf '\t%s\n' "-M, --list-monitors: List all available fswatch monitors and exit. See 'https://github.com/emcrisostomo/fswatch/wiki' for more information on each monitor and what it does (off by default)"
    printf '\t%s\n' "--: to tell nomon.sh stop slurping arguments, any arguments after this will be passed as arguments to the program you stipulated (no default)"
    printf '\t%s\n' "-c, --clear-screen, --no-clear-screen: clear the screen between each run (off by default)"
    printf '\t%s\n' "-h, --help: Prints help"
}


parse_commandline()
{
    _positionals_count=0
    while test $# -gt 0
    do
        _key="$1"
        case "$_key" in
            -e|--ext)
                test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
                _arg_ext+=("$2")
                shift
                ;;
            --ext=*)
                _arg_ext+=("${_key##--ext=}")
                ;;
            -e*)
                _arg_ext+=("${_key##-e}")
                ;;
            -x|--exec)
                test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
                _arg_exec="$2"
                shift
                ;;
            --exec=*)
                _arg_exec="${_key##--exec=}"
                ;;
            -x*)
                _arg_exec="${_key##-x}"
                ;;
            -w|--watch)
                test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
                _arg_watch+=("$2")
                shift
                ;;
            --watch=*)
                _arg_watch+=("${_key##--watch=}")
                ;;
            -w*)
                _arg_watch+=("${_key##-w}")
                ;;
            -i|--ignore)
                test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
                _arg_ignore+=("$2")
                shift
                ;;
            --ignore=*)
                _arg_ignore+=("${_key##--ignore=}")
                ;;
            -i*)
                _arg_ignore+=("${_key##-i}")
                ;;
            -m|--monitor)
                test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
                _arg_monitor="$2"
                shift
                ;;
            --monitor=*)
                _arg_monitor="${_key##--monitor=}"
                ;;
            -m*)
                _arg_monitor="${_key##-m}"
                ;;
            -M|--list-monitors)
                _arg_list_monitors="on"
                ;;
            -M*)
                _arg_list_monitors="on"
                _next="${_key##-M}"
                if test -n "$_next" -a "$_next" != "$_key"
                then
                    { begins_with_short_option "$_next" && shift && set -- "-M" "-${_next}" "$@"; } || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
                fi
                ;;
            # CUSTOM
            --)
                shift
                break
                ;;
            # END CUSTOM
            -c|--no-clear-screen|--clear-screen)
                _arg_clear_screen="on"
                test "${1:0:5}" = "--no-" && _arg_clear_screen="off"
                ;;
            -c*)
                _arg_clear_screen="on"
                _next="${_key##-c}"
                if test -n "$_next" -a "$_next" != "$_key"
                then
                    { begins_with_short_option "$_next" && shift && set -- "-c" "-${_next}" "$@"; } || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
                fi
                ;;
            -h|--help)
                print_help
                exit 0
                ;;
            -h*)
                print_help
                exit 0
                ;;
            *)
                _last_positional="$1"
                _positionals+=("$_last_positional")
                _positionals_count=$((_positionals_count + 1))
                ;;
        esac
        shift
    done
}


assign_positional_args()
{
    local _positional_name _shift_for=$1
    _positional_names=""
    _our_args=$((${#_positionals[@]} - 0))
    for ((ii = 0; ii < _our_args; ii++))
    do
        _positional_names="$_positional_names _arg_arguments[$((ii + 0))]"
    done

    shift "$_shift_for"
    for _positional_name in ${_positional_names}
    do
        test $# -gt 0 || break
        eval "$_positional_name=\${1}" || die "Error during argument parsing, possibly an Argbash bug." 1
        shift
    done
}

parse_commandline "$@"
prereqCheck fswatch realpath
assign_positional_args 1 "${_positionals[@]}"


# -------- ARGBASH DONE -----------

# If -M or --list-monitors was called, we will pass the argument on to `fswatch` and be done.

if [ "$_arg_list_monitors" = "on" ]
then
    fswatch -M
    exit $?
fi


# Since we stop evaluating arguments after the -- argument, we need to tack everything after that onto _arg_arguments
assignRestOfArguments() {
    # drop everything until --
    while test $# -gt 0
    do
        if [ "$1" = '--' ]
        then
            # get rid of the '--' argument, and break out of loop
            shift
            break
        fi
        shift
    done

    # early exit if there are no arguments left
    if [ $# -le 0 ]
    then
        return 0
    fi

    _arg_arguments+=("$@")
}

evaluateRealPaths() {
    local -a realPaths
    local tmpRealPath
    while test $# -gt 0
    do
        tmpRealPath=$(realpath "$1" 2> /dev/null)
        if [ $? -eq 0 ]
        then
            realPaths+=( "$tmpRealPath" )
        fi
        shift
    done

    if [ "${#realPaths[@]}" -gt 0 ]
    then
        pushEscapeSeparator " "
        escapeAll "${realPaths[@]}"
        popEscapeSeparator
        return 0
    else
        return 1
    fi
}

evaluateExtensions() {
    while test $# -gt 0
    do
        local extension=$1
        printf ' %s' "${extension#.}"
        shift
    done
}

assignRestOfArguments "$@"
watchPaths=($(evaluateRealPaths "${_arg_watch[@]}"))
test "${#_arg_ext[@]}" -gt 0 && doWatchExtension="on" || doWatchExtension="off"
test "${#_arg_watch[@]}" -eq 0 && _arg_watch+=("$PWD")
test "${#_arg_ignore[@]}" -gt 0 && doWatchIgnore="on" || doWatchIgnore="off"
test "$doWatchExtension" = "on" && watchExtensions=($(evaluateExtensions "${_arg_ext[@]}")) || watchExtensions=()

pendingTaskPid="nope"

runInBackground() {
    eval "$@" &
    local jobPid=$!
    pendingTaskPid="$jobPid"
}

handleSigInt() {
    # a more thorough way of ending all tasks
    pkill -g "$$"
    exit 0
}


trap "" SIGCHLD
trap handleSigInt SIGINT


isInPaths() {
    local toCheck=$1
    shift
    while test $# -gt 0
    local pathMatch=$1
    do
        if [[ "$toCheck" =~ "${pathToMatch}*" ]]
        then
            return 0
        fi
    shift
    done

    return 1
}

findChildPids () {
    local startingPid=$1
    local -a myStack=( $startingPid )
    local -a resultPids
    local nextPid
    local childPids


    while [ ${#myStack[@]} -gt 0 ]
    do
        nextPid=${myStack[0]}
        myStack=("${myStack[@]:1}")
        childPids="$(pgrep -P $nextPid)"
        if [ $? -ne 0 ]
        then
            continue
        fi

        for childPid in $childPids
        do
            # only add pid if it's not already present
            if [[ " ${resultPids[*]} " =~ [[:space:]]${childPid}[[:space:]] ]]
            then
                continue
            else
                resultPids+=($childPid)
                myStack+=($childPid)
            fi
        done
    done
    printf "${resultPids[*]}"
}

hasWatchedExtension() {
    local filename="$(basename "$1")"
    local filenameTerminator="${filename##*.}"
    if [[ " ${watchExtensions[*]} " =~ " ${filenameTerminator} " ]]
    then
    return 0
    fi
    return 1
}

nomonBatchSeparator="NodemonEndBatch"

handleFileChange() {
    local doReload="false"
    while IFS="\n" read fileThatChanged
    do
        if [ "$fileThatChanged" != "$nomonBatchSeparator" ]
        then
            if [ "$doReload" = "false" ]
            then
                if [ "$doWatchExtension" = "off" ]
                then
                    doReload="true"
                else
                    hasWatchedExtension "$fileThatChanged"
                    local tmpRes=$?
                    doReload="$(test "$tmpRes" -eq 0 && printf 'true' || printf 'false')"
                fi
            fi
        else
            local tmpDoReload="$doReload"
            doReload="false"
            if [ "$tmpDoReload" = "true" ]
            then
                handleStartNewProcess
            fi
        fi
    done <"${1:-/dev/stdin}"
}

handleKillProcess() {
    if [ "$pendingTaskPid" = "nope" ]
    then
        return 0
    fi

    local childPids="$(findChildPids  $pendingTaskPid)"
    if [ -n "$childPids" ]
    then
        kill $childPids 2>/dev/null
    fi

    pendingTaskPid="nope"
}

handleStartNewProcess() {
    handleKillProcess
    if [ "$_arg_clear_screen" = "on" ]
    then
        clear
        printf '\e[3J'
    fi
    runInBackground "$_arg_exec" $(escapeAll "${_arg_arguments[@]}")
}

handleStartNewProcess

fswatchMonitorOverride="$(test -n "$_arg_monitor" && printf '%s %s' '-m' "$_arg_monitor" || printf '')"
watchIgnoreFlag="$(test "$doWatchIgnore" = "on" && printf ' -e '"\'"'%s'"\'"' ' "${_arg_ignore[@]}" || printf '')"

sh -c "fswatch --batch-marker="$nomonBatchSeparator" -r --extended $watchIgnoreFlag $fswatchMonitorOverride ${watchPaths[@]}" | handleFileChange

handleKillProcess
