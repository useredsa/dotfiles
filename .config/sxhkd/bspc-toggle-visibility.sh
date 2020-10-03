#!/bin/env sh

if [ $# = 0 ]; then
    cat <<EOF
Usage: $(basename "${0}") classname [executable_name] [--instancename] [--take-first] [--state <bspwm_state>] [--unamed-rule]
	classname      	Window class name as recognized by `xdo -N` command
	executable_name	As used for launching from terminal. Defaults to classname
	--instancename  Use classname as if it were the instance name
	--take-first	Choose firt in case xdo returns multiple process IDs
	--state         Set the window to the given state
	--unnamed-rule  Use * instead of the class name to set a bspwm rule
EOF
    exit 1
fi

classname="$1"
executable="$1"
shift

# Get id of process by class name and then fallback to instance name
id=$(xdo id -N "$classname" || xdo id -n "$classname")

while [ -n "$1" ]; do
    case $1 in
        --take-first)
            id=$(head -1 <<<"$id" | cut -f1 -d' ')
            ;;
        --state)
            shift
            state="--state $1"
            state_="state=$1"
            ;;
        --unnamed-rule)
            classname="*"
            ;;
        --instancename)
            classname="*:$classname"
            ;;
        *)
            executable="$1"
            ;;
    esac
    shift
done

if [ -z "$id" ]; then
    bspc rule --add "$classname" -o "$state_"
    $executable
else
    while read -r instance; do
        bspc node "$instance.!local" --flag hidden=off
        bspc node "$instance.local" --flag hidden
        bspc node "$instance" --to-desktop focused
        bspc node "$instance" $state
        bspc node "$instance" --focus
        #TODO make window disappear upon changing workspace
    done <<<"$id"
fi
