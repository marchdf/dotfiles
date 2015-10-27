#!/bin/sh
#
# Another way to convert pdf to eps. See http://tex.stackexchange.com/questions/20883/how-to-convert-pdf-to-eps

# pdf2epsv2 <pdf file with extension> <outfile with extension>

pdf2ps "$1" "$1-temp.ps";
ps2eps -f "$1-temp.ps" ;
mv "$1-temp.eps" "$2";
rm  -f "$1-temp.ps";