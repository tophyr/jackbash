#!/bin/bash

BASHRCDIR="$HOME/bash"

function settings_iter() {
    local dir=$1
    local func=$2
    shift 2
    for settings in default group local private; do
        [ -d "$BASHRCDIR"/"$settings"/"$dir" ] || continue

        $func "$BASHRCDIR"/"$settings"/"$dir" $@
    done
}

function process_settingsdir() {
    local dir=$1
    local func=$2
    local file
    for file in "$dir"/*; do
        if [ -f "$file" ]; then
            echo $func "$file"
            { time $func "$file"; } 2>&1
        else
            echo "WARN: $file not a valid $func definition file" >&2
        fi
    done
}

{
  function load_alias() { alias $(basename $1)="$(cat $1)"; }
  settings_iter aliases process_settingsdir load_alias

  settings_iter functions process_settingsdir source

  source "$BASHRCDIR/envdefs"

  settings_iter completions process_settingsdir source
} > "$BASHRCDIR"/timing.log


unset settings_iter
unset process_settingsdir
unset load_alias
unset BASHRCDIR


# Options
shopt -s checkwinsize
shopt -s histappend   # Append to history rather than overwrite

# special case
alias ..='cd ..'
