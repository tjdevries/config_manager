#!/usr/bin/bash

export DEFAULT_VIDEO="/dev/video0"
function set_vid_option {
  v4l2-ctl -d $DEFAULT_VIDEO --set-ctrl $1=$2
}

set_vid_option white_balance_temperature_auto 0
set_vid_option white_balance_temperature 4500
set_vid_option gain 64
set_vid_option backlight_compensation 0
set_vid_option brightness 110
set_vid_option exposure_auto 0
