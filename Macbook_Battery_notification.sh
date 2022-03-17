#!/bin/bash
# <xbar.title>Battery management</xbar.title>
# <xbar.version>1.0</xbar.version>
# <xbar.author>Aland Mariwan</xbar.author>
# <xbar.author.github>amariwan</xbar.author.github>
# <xbar.desc>Get your battery cycles and as far as your macbook has reached 75% or 30% charge and condition on the menu bar !</xbar.desc>
#

# Get cycles number
cycles=$(system_profiler SPPowerDataType | grep "Cycle Count" | awk '{print $3}')

# Get battery condition
condition=$(system_profiler SPPowerDataType | grep "Condition" | sed -e 's/^.*: //')

# Get battery condition
BatteryStatus=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)

# If you want to change the emoticon before the number, here are some
#echo "🔋 $cycles"
#echo "♾ $cycles"
#echo "♽ $cycles"

echo "♽ $cycles"

echo "---"

# 1000 cycles maximum
# Based on the cycles max number provided by Apple for all Macbooks after 2009
# No way to get the Macbook age from script directly

color=green
if [ "$cycles" -gt 1000 ]; then
    color=red
elif [ "$cycles" -gt 750 ]; then
    color=orange
fi

echo "Cycles: $cycles / 1000 | color=$color href='https://support.apple.com/en-us/HT201585'"



color=green
if [ "$condition" != "Normal" ]; then
    color=red
fi

echo "Battery condition: $condition | color=$color"




color=green
if [ "$BatteryStatus" -ge "75" ]; then
    color=red
    display notification "Battery Status 75" with title "Battery management"
fi

if [ "$BatteryStatus" –le "30" ]; then
    color=red
    display notification "Battery Status 30" with title "Battery management"
fi
