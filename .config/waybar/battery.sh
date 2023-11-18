full=`cat /sys/class/power_supply/BAT0/charge_full`
current=`cat /sys/class/power_supply/BAT0/charge_now`
echo $(bc -l <<< "(100 / $full * $current)/1")

# bat=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage`

