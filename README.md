# nomon.sh

It's NodeMon without Node.

## Project description

`nomon.sh` monitors your files/directories and runs a command whenever they change.

Under the hood it's just a script that uses `fswatch`, but it also handles process termination and, optionally, screen clearing.

YMMV, it works on my machine etc, but I am very open to PRs if you find and fix a problem.

## Usage

Usage is quite similar to NodeMon but has a few additional options related to `fswatch`.

```shell
Usage: nomon.sh [-e|--ext <arg>] [-x|--exec <arg>] [-w|--watch <arg>] [-i|--ignore <arg>] [-m|--monitor <arg>] [-M|--(no-)list-monitors] [--REPLACEME <arg>] [-c|--(no-)clear-screen] [-h|--help] [<arguments-1>] ... [<arguments-n>] ...
        <arguments>: to be passed to the specified executable (set with the --exec argument)
        -e, --ext: extensions to look for, ie. js. use once for each extension to watch (empty by default)
        -x, --exec: execute arguments with executable, ie, -x "python -v" (default: 'sh -c')
        -w, --watch: watch directory or files. use once for each directory or file to watch (empty by default)
        -i, --ignore: ignore the given regex pattern. use once for each pattern you would like to ignore (empty by default)
        -m, --monitor: Specify the fswatch monitor to use. Use the --list-monitors (-M) flag to list all available fswatch monitors (let fswatch choose by default)
        -M, --list-monitors: List all available fswatch monitors and exit. See 'https://github.com/emcrisostomo/fswatch/wiki' for more information on each monitor and what it does (off by default)
        --: to tell nomon.sh stop slurping arguments, any arguments after this will be passed as arguments to the program you stipulated (no default)
        -c, --clear-screen, --no-clear-screen: clear the screen between each run (off by default)
        -h, --help: Prints help
```

The `--ignore` option uses [POSIX Extended Regular Expressions](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_04), not glob. Might change this in the future.

## Installation


Add `<this-folder>/bin` to your path.

### Just give me a script

Okay fine. If you have `git` installed, here are some copy-paste commands for installation:

#### Install and add to path for `bash` users:

```shell
git clone --depth 1 https://github.com/mattrcole/nomon "${HOME}/.nomon"

printf '
# Add nomon.sh to path
export PATH="${PATH}:${HOME}/.nomon/bin"
# Add nomon.sh completions
source "${HOME}/.nomon/completions/nomon_sh_completions.sh"\n
' >> "${HOME}/.profile"
```



#### Install and add to path for `zsh` users:

```shell
git clone --depth 1 https://github.com/mattrcole/nomon "${HOME}/.nomon"

printf '
# Add nomon.sh to path
export PATH="${PATH}:${HOME}/.nomon/bin"
# Add nomon.sh completions
autoload -Uz "${HOME}/.nomon/completions/_nomon.sh"\n
compdef _nomon.sh nomon.sh
' >> "${HOME}/.zshrc"
```

#### Wait, I use a different shell!

Feel free to make a PR to update the readme!

## Uninstall


- Remove `<this-folder>/bin` from your path

- Remove any related `nomon.sh` entries from your shell's config (`.profile` for `bash` and `.zshrc` for zsh)


## Example usage

It uses almost the same options as `NodeMon`, so if you've used that tool, it should be familiar.

Run pytest whenever a file changes in the current directory:

`nomon.sh --ext py --watch . --ignore '.*__pycache__.*' --ignore '\.git.*' --exec "python -m" --clear-screen -- pytest .`

The same command with "short" options:

`nomon.sh -e py -w . -i '.*__pycache__.*' -i '\.git.*' -x "python -m" -c -- pytest .`


For additional help run:

`nomon.sh --help`
