

# Only start this up when this isn't already going.
if xrandr | grep -q 'DP-1' ; then
    MAIN_DISPLAY=$(xrandr | grep '^DP-1.* connected' | awk '{print $1;}')
    LAPTOP_DISPLAY=$(xrandr | grep '^eDP-1.* connected' | awk '{print $1;}')
    xrandr --auto --output $MAIN_DISPLAY --mode 3840x2160 --right-of $LAPTOP_DISPLAY --output $LAPTOP_DISPLAY --mode 3840x2400
fi

