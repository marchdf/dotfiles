#!/bin/bash
#
# 
#
function myHelp () {
    cat <<-END
Usage:
------
   -h | --help
     Convert a jpg image to an eps. Takes only one argument: the name of the jpg image

   jpg2eps image.jpg
END
}

case "$1" in
    -h | --help)
        myHelp
        exit
        ;;
    *)
	echo "Converting $1 to an eps file."
	file=$1
	convert "$file" eps2:$(echo "$file" | sed 's/\.jpg$/\.eps/')
	shift
	;;
esac 



