#!/bin/bash
set -e -u

if [ "$1" = "jack/headphone" -a "$2" = "HEADPHONE" ]; then
    case "$3" in
        plug)
            sink=dsp
	    ;;
        *)
            sink=alsa_output.pci-0000_00_1f.3.analog-stereo
            ;;
    esac
    for userdir in /run/user/*; do
        uid="$(basename $userdir)"
        user="$(id -un $uid)"
        if [ -f "$userdir/pulse/pid" ]; then
            PULSE_RUNTIME_PATH="$userdir/pulse" su "$user" -c "paswitch $sink"
        fi
    done
fi
