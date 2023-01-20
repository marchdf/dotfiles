#!/usr/bin/env python3

import os
import re
import argparse
import subprocess as sp

# Parse arguments
parser = argparse.ArgumentParser(
    description="Split a multipage pdf into separate files."
)
parser.add_argument("-f", "--fname", help="PDF file to split", required=True)
args = parser.parse_args()

# Get number of pages
cmd = """gs -q -dNODISPLAY -c "("{0:s}") (r) file runpdfbegin pdfpagecount = quit" 2>/dev/null""".format(
    args.fname
)
process = sp.Popen(cmd, stdout=sp.PIPE, stderr=sp.PIPE, shell=True)
output, error = process.communicate()
np = int(re.findall(r"\d+", output.decode("utf-8"))[0])

# Extract pages
for i in range(0, np):
    os.system(
        "gs -q -dBATCH -dNOPAUSE -sOutputFile={oname}_{cnt:04d}.pdf"
        " -dFirstPage={page} -dLastPage={page}"
        " -sDEVICE=pdfwrite {input_pdf}".format(
            page=i + 1,
            cnt=i,
            input_pdf=args.fname,
            oname=os.path.splitext(args.fname)[0],
        )
    )
