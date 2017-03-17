#!/bin/sh
#

function myHelp () {
    cat <<-END
Usage:
------
   -h | --help
     Convert PDF to encapsulated PostScript (crops the pdf to remove white border)
     Inspired by http://tex.stackexchange.com/questions/20883/how-to-convert-pdf-to-eps
     and inspired from pdf2eps, v 0.01 2005/10/28 00:55:46 Herbert Voss Exp

   pdf2eps pdf-file-without-ext
END
}

while [ -n "$1" ]; do
    case "$1" in
        -h | --help)
            myHelp
            exit
            ;;
	*)
	    echo "Converting $1.pdf to an eps file."
	    pdfcrop "$1.pdf" "$1-temp.pdf"
	    gs -q -dNOCACHE -dNOPAUSE -dBATCH -dSAFER -sDEVICE=eps2write -sOutputFile="$1.eps" "$1-temp.pdf"
	    rm  "$1-temp.pdf"
	    shift
	    ;;
    esac 
done 
