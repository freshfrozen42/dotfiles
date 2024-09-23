#!/usr/bin/bash

set -u

_idle() {
  pkill swayidle
  idle_timeout=${1:-120}
  sleep_timeout=${2:-300}

  swayidle -w \
    timeout $idle_timeout 'swaylock && swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' \
    timeout $sleep_timeout 'systemctl suspend' &
}

_lock() {
  pkill swayidle
  idle_timeout=${1:-120}
  sleep_timeout=${2:-300}

  swayidle -w \
    timeout $idle_timeout 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' \
    timeout $sleep_timeout 'systemctl suspend' &
  
  [[ -z `pidof swaylock` ]] && swaylock
}

[[ $SWAYSOCK ]] && {
  arg=${1:-}
  shift

  case $arg in
    idle  ) _idle $@;;
    now   ) _lock $@;;
    *     ) _idle;;
  esac
}
