#! /bin/bash
# converts png to eps
#
# 2003-04-09 Thomas Henlich
#
# requires: pngcheck pngtopnm sed basename
#           pnmtotiff tiff2ps
#           bc (for images with non-square pixels)
#
# Usage:
# png2eps file.png > file.eps

# for maximum compression set this to -lzw
# (requires LZW compression in pnmtotiff and tiff2ps)
COMPRESS=-packbits
#COMPRESS=-lzw

# we need a tmp file for input to tiff2ps
OUTFILE=/tmp/png2eps.tif.$$

# temp file for the tEXt chunk
TXTFILE=/tmp/png2eps.txt.$$

# command to remove files
RM="rm -f"

# get the resolution (if specified) from the PNG file
CHK=`pngcheck -v $1`

# get height in pixels from the PNG file
HEIGHT=`echo $CHK | sed -ne 's/.* [0-9]\+ x \(.*\) image.*/\1/p;'`

# a rowsperstrip parameter of 'height' (or more) is needed to generate one 
# single strip of data in the TIFF file (reduces file size)
ROWSPERSTRIP="-rowsperstrip $HEIGHT"
# ROWSPERSTRIP="rowsperstrip 1000000"

# for images with square pixels, pngcheck outputs a line like
#   chunk pHYs ... 9646x9646 pixels/meter (245 dpi)
# and we can read the resolution in dpi directly
RES=`echo $CHK | sed -ne '/pHYs/s/.*(\(.*\) dpi.*/\1/p;'`

# for images with non-square pixels, pngcheck outputs a line like
#   chunk pHYs ... 9646x4803 pixels/meter
XRES=`echo $CHK | sed -ne '/pHYs/s/.*: \([0-9]*\)x.* pixels\/meter.*/\1/p;'`
YRES=`echo $CHK | sed -ne '/pHYs/s/.*x\([0-9]*\) pixels\/meter.*/\1/p;'`

# for images with no fixed resolution, pngcheck may output a line like
#   chunk pHYs ... 9646x4803 pixels/unit
# we ignore it (like pdfTeX does)

# set the command-line arguments for pnmtotiff which specify the resolution
if [ "$RES" ] ; then
  echo "png2eps: Image with square pixels ($RES dpi)" 1>&2
  RES='-xres '$RES' -yres '$RES
fi
if [ -z "$RES" ] ; then
  if [ "$XRES" ] ; then
    echo "png2eps: Image with non-square pixels" \
      "($XRES""x$YRES pixels/meter)" 1>&2
# we still have to convert pixels/meter -> dpi
    RES='-xres '`echo .0254*$XRES |bc`' -yres '`echo .0254*$YRES |bc`;
  else
# no resolution was specified and so a default of 72 dpi will be used
    echo "png2eps: No resolution specified, using default (72 dpi)" 1>&2;
  fi
fi

# convert to tiff
pngtopnm -verbose -text $TXTFILE $1 | \
pnmtotiff $ROWSPERSTRIP $RES $COMPRESS -indexbits=1,2,4,8 >$OUTFILE

# get the title of the figure
TITLE="`sed -ne 's/^Title *\(.*\)/\1/p;' <$TXTFILE`"
# set to input file name if unspecified
[ -z "$TITLE" ] && TITLE=`basename $1`

# convert to EPS, replacing the %%Title comment
tiff2ps -2 -e $OUTFILE | sed -e "s/^\(%%Title: \).*/\1$TITLE/;"

# remove temp files
$RM $OUTFILE $TXTFILE