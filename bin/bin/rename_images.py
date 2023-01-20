#!/usr/bin/env python3
"""
Rename pictures in folder based on Exif data

Core functions taken from https://code.activestate.com/recipes/576646-exif-date-based-jpeg-files-rename-using-pil/
"""

import os
import sys
import glob
import time
from datetime import timedelta
import PIL.Image
import re
import argparse


def extract_jpeg_exif_time(fname):
    if not os.path.isfile(fname):
        return None
    try:
        im = PIL.Image.open(fname)
        if hasattr(im, '_getexif'):
            exifdata = im._getexif()
            ctime = exifdata[0x9003]
            return ctime
    except BaseException:
        _type, value, traceback = sys.exc_info()
        print("Error:\n%r", value)

    return None


def get_exif_prefix(fname):
    ctime = extract_jpeg_exif_time(fname)
    if ctime is None:
        return None
    ctime = ctime.replace(':', '')
    ctime = re.sub('[^\d]+', '_', ctime)
    return ctime


def rename_jpeg_file(fname):
    if not os.path.isfile(fname):
        return 0
    path, base = os.path.split(fname)
    ext = os.path.splitext(fname)[1].lower()
    prefix = get_exif_prefix(fname)
    if prefix is None:
        return 0
    if base.startswith(prefix):
        return 0  # file already renamed to this prefix

    oname = prefix + ext
    print("Renaming", base, "to", prefix + ext)
    try:
        os.rename(fname, os.path.join(path, oname))
    except BaseException:
        print('ERROR rename %s --> %s' % (fname, oname))
        return 0

    return 1


if __name__ == '__main__':

    # Timer
    start = time.time()

    # Parse arguments
    parser = argparse.ArgumentParser(
        description='Rename images based on picture shot time')
    parser.add_argument('-f',
                        '--folder',
                        help='Folder to scan for images',
                        required=True)
    args = parser.parse_args()

    # Get the image file names
    extensions = ['*.jpg', '*.jpeg', '*.JPG', '*.JPEG']
    fnames = []
    for ext in extensions:
        fnames.extend(glob.glob(os.path.join(args.folder, ext)))

    # Rename them all
    for fname in fnames:
        rename_jpeg_file(fname)

    # output timer
    end = time.time() - start
    print("Elapsed time " + str(timedelta(seconds=end)) +
          " (or {0:f} seconds)".format(end))
