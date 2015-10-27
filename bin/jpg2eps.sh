#!/bin/bash
#
# Convert a jpg image to an eps. Takes only one argument: the name of the jpg image
#

file=$1
convert "$file" eps2:$(echo "$file" | sed 's/\.jpg$/\.eps/')
