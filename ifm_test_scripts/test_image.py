#!/usr/bin/env python
# convert test_out.txt data to an image

import sys
import numpy as np
from PIL import Image

import test_ifm_utils as ifm

def main(path):
    # read the file
    f = open(path)
    lines = f.readlines()[1:] # throw away first line
    data = [l.split(" ") for l in lines]
    # convert the location data
    data = [(ifm.from_fixed(int(d[1], 2)),
             ifm.from_fixed(int(d[2], 2)),
             int(d[3])) for d in data]
    # find the range of the data
    #arange = (min([d[0] for d in data]), max([d[0] for d in data]))
    #brange = (min([d[1] for d in data]), max([d[1] for d in data]))
    arange = (-2.0, 2.0)
    brange = (-1.0, 1.0)
    # init the image
    img = np.zeros((480,640), np.uint8)
    # write out the data
    for d in data:
        x = round((d[0]+arange[0])/(arange[1]-arange[0])*640)%640
        y = round((d[1]+brange[0])/(brange[1]-brange[0])*480)%480
        img[y][x] = 2*d[2]
    # write out the file
    im = Image.fromarray(img, mode="L")
    im.save("ifm_test.png")


if __name__=="__main__":
    # default path
    if len(sys.argv) == 2:
        path = sys.argv[1]
    else:
        path = "test_out.txt"
    main(path)
