#!/bin/sh
#

function myHelp () {
    cat <<-END
Usage:
------
   -h | --help
     Another way to convert PDF to encapsulated PostScript (does not crop the pdf to remove white border)
     Inspired by http://tex.stackexchange.com/questions/20883/how-to-convert-pdf-to-eps

   pdf2epsv2 <pdf file with extension> <outfile with extension>
END
}

case "$1" in
    -h | --help)
        myHelp
        exit
        ;;
    *)
	echo "Converting $1.pdf to an eps file called $2."
	pdf2ps "$1" "$1-temp.ps";
	ps2eps -f "$1-temp.ps" ;
	mv "$1-temp.eps" "$2";
	rm -f "$1-temp.ps";
	shift
	;;
esac 
