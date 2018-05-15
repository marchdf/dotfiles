#!/bin/bash
#
# 
#
function myHelp () {
    cat <<-END
Usage:
------
   -h | --help
     Convert a movie to a gif. Takes only one argument: the name of the movie
     From Brandon.

   movie2gif sample.mp4
END
}

case "$1" in
    -h | --help)
        myHelp
        exit
        ;;
    *)
	echo "Converting $1 to an gif file."
	MYTEMPDIR=$(mktemp -d)
	ffmpeg -i "$1" "$MYTEMPDIR/out%04d.gif" # Extracts each frame of the video as a single gif
	convert -delay 4 "$MYTEMPDIR/out*.gif" "$MYTEMPDIR/anim.gif" # Combines all the frames into one very nicely animated gif.
	convert -layers Optimize "$MYTEMPDIR/anim.gif" "$2" # Optimizes the gif using imagemagick

	# Cleans up the leftovers
	rm -r "$MYTEMPDIR"
	shift
	;;
esac 



