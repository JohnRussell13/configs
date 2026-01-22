#!/usr/bin/env bash

if pgrep -x wvkbd-mobintl > /dev/null; then
    echo 'HI'
    pkill -x wvkbd-mobintl
else
    wvkbd-mobintl -L 400 &
fi
