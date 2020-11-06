#!/usr/bin/env bash

bspc subscribe desktop_focus desktop_layout | while read line; do
    bspc query --tree --desktop focused | jq --raw-output '.layout'
done
