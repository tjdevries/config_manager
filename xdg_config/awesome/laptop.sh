#!/bin/bash

export LAPTOP_DISPLAY=$(xrandr | grep '^eDP-1.* connected' | awk '{print $1;}')
xrandr --auto --output $LAPTOP_DISPLAY --mode 3840x2160
