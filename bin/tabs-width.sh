#!/usr/bin/env bash

# source: https://unix.stackexchange.com/a/582746

echo -ne 'a\tb'  &&
    echo -ne "\033[6n"            # ask the terminal for the position
read -rs -d\[ _                   # discard the first part of the response
read -rs -dR foo                  # store the position in bash variable 'foo'
foo=$(cut -d";" -f2 <<< "$foo")   # discard row number
printf "\r\e[0K%d\n" $((foo - 2)) # subtract 2 for 'a' and 'b'
