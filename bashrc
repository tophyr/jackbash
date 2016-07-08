#!/bin/bash
BASHRCDIR="$HOME/bash"

source "$BASHRCDIR/aliasdefs"

source "$BASHRCDIR/functiondefs"

source "$BASHRCDIR/envdefs"

source "$BASHRCDIR/completiondefs"


# Options
shopt -s checkwinsize
shopt -s histappend   # Append to history rather than overwrite
