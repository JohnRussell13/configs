#!/usr/bin/env bash

# Get the highest workspace number using swaymsg + grep + sort
next=$(swaymsg -t get_workspaces -r \
  | grep -o '"num": [0-9]\+' \
  | grep -o '[0-9]\+' \
  | sort -n \
  | tail -n1)

# If no numbered workspace exists, start at 1
if [ -z "$next" ]; then
  next=1
else
  next=$((next + 1))
fi

swaymsg workspace number "$next"
