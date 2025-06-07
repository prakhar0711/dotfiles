#!/bin/bash

cava -p ~/.config/cava/config | \
while read -r line; do
    echo "$line" | tr -d ';' | \
    sed 's/0/▁/g; s/1/▂/g; s/2/▃/g; s/3/▄/g; s/4/▅/g; s/5/▆/g; s/6/▇/g; s/7/█/g; s/8/█/g; s/9/█/g'
done

