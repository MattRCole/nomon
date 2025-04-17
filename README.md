# nomon.sh

It's NodeMon without Node.

## Project description

A very large script that uses `fswatch` to emulate NodeMon's behaviors.

YMMV, it works on my machine etc, but I am very open to PRs if you find and fix a problem.


## Installation


Add `<this-folder>/bin` to your path.


## Uninstall


Remove `<this-folder>/bin` from your path


## Example usage

It uses almost the same options as `NodeMon`, so if you've used that tool, it should be familiar.

Run pytest whenever a file changes in the current directory:

`nomon.sh -e py -w . -i '.*__pycache__.*' -i '\.git.*' -x "python -m" -c -- pytest .`


For additional help run:

`nomon.sh --help`
