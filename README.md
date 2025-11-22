# nomon.sh

It's NodeMon without Node.

## Project description

`nomon.sh` monitors your files/directories and runs a command whenever they change.

Under the hood it's just a script that uses `fswatch`, but it also handles process termination and, optionally, screen clearing.

YMMV, it works on my machine etc, but I am very open to PRs if you find and fix a problem.

## Usage

Usage is quite similar to NodeMon but has a few additional options related to `fswatch`.

```shell
Usage: nomon.sh [-e|--ext <arg>] [-x|--exec <arg>] [-w|--watch <arg>] [-i|--ignore <arg>] [-m|--monitor <arg>] [-M|--(no-)list-monitors] [-d|--(no-)ignore-dotfiles|-D] [-c|--(no-)clear-screen] [-h|--help] [--] [<arguments-1>] ... [<arguments-n>] ...
        <arguments>: To be passed to the specified executable (set with the --exec argument)
        -e, --ext: Extensions to look for, ie. js. use once for each extension to watch (empty by default)
        -x, --exec: Execute arguments with executable, ie, -x "python -v" (default: 'sh -c')
        -w, --watch: Watch directory or files. use once for each directory or file to watch (current directory by default)
        -i, --ignore: Ignore the given regex pattern. use once for each pattern you would like to ignore (empty by default)
        -m, --monitor: specify the fswatch monitor to use. Use the --list-monitors (-M) flag to list all available fswatch monitors (let fswatch choose by default)
        -M, --list-monitors: List all available fswatch monitors and exit. See 'https://github.com/emcrisostomo/fswatch/wiki' for more information on each monitor and what it does (off by default)
        -d, --ignore-dotfiles: Ignore any folder/file that begins with a '.' equivalent to adding -i '(^|.*/)\.[^/].*' (on by default)
        -D, --no-ignore-dotfiles: Do not ignore folders/files that begin with a '.' (off by default)
        --: Tell nomon.sh stop slurping arguments, any arguments after this will be passed as arguments to the program you stipulated (no default)
        -c, --clear-screen, --no-clear-screen: Clear the screen between each run (off by default)
        -h, --help: Prints help
```

The `--ignore` option uses [POSIX Extended Regular Expressions](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_04), not glob. Might change this in the future.

### Example usage

It uses almost the same options as `NodeMon`, so if you've used that tool, it should be familiar.

Run pytest whenever a file changes in the current directory:

`nomon.sh --ext py --watch . --ignore '.*__pycache__.*' --ignore '\.git.*' --exec "python -m" --clear-screen -- pytest .`

The same command with "short" options:

`nomon.sh -e py -w . -i '.*__pycache__.*' -i '\.git.*' -x "python -m" -c -- pytest .`

For additional help run:

`nomon.sh --help`

## Installation

Make sure you have [`fswatch`](https://github.com/emcrisostomo/fswatch) installed.

### Installing `fswatch`:

#### On `macOs` with `homebrew`:

```shell
brew install fswatch
```

#### On debian based `linux` distributions:

```shell
sudo apt update && sudo apt install fswatch
```

#### Windows an other systems

Note for `Windows`:

While you can install `fswatch`, `nomon.sh` doesn't run directly on windows. You will have to use a tool like [`MinGW`](https://www.mingw-w64.org/) or `WSL` to run `nomon.sh`.

Please see [`fswatch`'s readme](https://github.com/emcrisostomo/fswatch?tab=readme-ov-file#getting-fswatch) for more info on installing `fswatch` on other systems.

### Installing `nomon.sh`:

#### `bash`: Install `nomon.sh` and enable completions:

```shell
git clone --depth 1 https://github.com/mattrcole/nomon "${HOME}/.nomon"

printf '
# Add nomon.sh to path
export PATH="${PATH}:${HOME}/.nomon/bin"
# Add nomon.sh completions
source "${HOME}/.nomon/completions/nomon_sh_completions.sh"\n
' >> "${HOME}/.profile"
```



#### `zsh`: Install `nomon.sh` and enable completions:

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

