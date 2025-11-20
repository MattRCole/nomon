#compdef nomon.sh

_nomon.sh() {
  _arguments -S \
    '(-e --ext)'{-e,--ext}'[Extensions to look for, ie. js. use once for each extension to watch]:extension:' \
    '(-x --exec)'{-x,--exec}'[Execute arguments with executable, ie, -x "python -v"]:executable:_command_names' \
    '(-w --watch)'{-w,--watch}'[Watch directory or files. use once for each directory or file to watch]:path:_files -/' \
    '(-i --ignore)'{-i,--ignore}'[Ignore the given regex pattern. use once for each pattern you would like to ignore]:pattern:->ignore-regex' \
    '(-m --monitor)'{-m,--monitor}'[Specify the fswatch monitor to use. Use the --list-monitors (-M) flag to list all available fswatch monitors]:monitor:->list-mons' \
    '(--)'--'[Tell nomon.sh stop slurping arguments, any arguments after this will be passed as arguments to the program you stipulated]::' \
    '(-M --list-monitors)'{-M,--list-monitors}'[List all available fswatch monitors and exit. See https://github.com/emcrisostomo/fswatch/wiki for more information on each monitor and what it does]' \
    '(-c --clear-screen)'{-c,--clear-screen}'[Clear the screen between each file change]' \
    '(-d --ignore-dotfiles)'{-d,--ignore-dotfiles}'[Ignore any folder/file that begins with a "." equivalent to adding -i '"'(^|.*/)\\\\.\\[^/\\].*'"' On by default]' \
    '(-D --no-ignore-dotfiles)'{-D,--no-ignore-dotfiles}'[do not ignore folders/files that begin with a .]' \
    '(-h --help)'{-h,--help}'[Prints help]' \
    '*::arguments:_files'


    case $state in
        list-mons)
            local availableMonitors="$(fswatch -M 2>/dev/null | tr -d ' ')"
            if [ -n "$availableMonitors" ]
            then
                _values 'available monitors' ${(f)availableMonitors}
            fi
        ;;
        ignore-regex)
            _message -r "POSIX extended regex pattern"
        ;;
    esac
}

compdef _nomon.sh nomon.sh