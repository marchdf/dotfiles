#!/bin/sh
# $Id: pdf2eps,v 0.01 2005/10/28 00:55:46 Herbert Voss Exp $
# see http://tex.stackexchange.com/questions/20883/how-to-convert-pdf-to-eps
# Convert PDF to encapsulated PostScript.
# usage:
# pdf2eps <page number> <pdf file without ext>

pdfcrop "$2.pdf" "$2-temp.pdf"
#pdftops -f $1 -l $1 -eps "$2-temp.pdf" "$2.eps"
gs -q -dNOCACHE -dNOPAUSE -dBATCH -dSAFER -sDEVICE=epswrite -sOutputFile="$2.eps" "$2-temp.pdf"
rm  "$2-temp.pdf"