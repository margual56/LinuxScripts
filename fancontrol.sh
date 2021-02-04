#!/bin/sh
# Check we have a 1 or 0 as first argument. If not, print help
if test "$1" != "1" -a "$1" != "0";
then
  echo "Usage: $0 <0|1>"
  return 1
fi

# One liner to test the existence of the pin pseudo-folder. If it does not exist, ask sysfs to create it and sleep for 1 second to let the OS do its work.
test ! -d /sys/class/gpio/gpio17 && echo "Exporting GPIO folder..." && echo "17" > /sys/class/gpio/export && sleep 1

echo "out" > /sys/class/gpio/gpio17/direction # Set pin as output
echo "$1" > /sys/class/gpio/gpio17/value # Set as high or low depending on argument
echo "Set fan state to $(cat /sys/class/gpio/gpio17/value)" # Echo operation to user

return 0