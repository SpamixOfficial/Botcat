#!/bin/sh

sleep 1

chromium-browser &

sleep 2

xdotool search --class chromium-browser windowactivate

sleep 6

xdotool key ctrl+l

sleep 1

xdotool type "popcat.click"

sleep 1 

xdotool key Return

sleep 3 

xdotool mousemove 960 540

sleep 3

while true
do
xdotool mousemove 960 540
sleep 0.5
xdotool click --repeat 400 --delay 10 1
sleep 3
done

