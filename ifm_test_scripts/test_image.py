#!/usr/bin/env python
# convert test_out.txt data to an image

import sys
import numpy as np
from PIL import Image
import pickle

# use steve's stuff
import test_ifm_utils as ifm

def main(path):
    # read the file
    f = open(path)
    line = f.readline() # throw away first line
    # init the image
    img = np.zeros((480,640), np.uint8)
    # find the range of the data
    print "Finding the range of the data"
    arange_min = 0
    arange_max = 0
    brange_min = 0
    brange_max = 0
    i = 0
    data = {}
    for line in f:
        elems = line.split(" ")
        d = (ifm.from_fixed(int(elems[1], 2)),
             ifm.from_fixed(int(elems[2], 2)))
        arange_min = min(arange_min, d[0])
        arange_max = max(arange_min, d[0])
        brange_min = min(arange_min, d[1])
        brange_max = max(arange_min, d[1])
        # writing once
        data[d] = int(elems[3])
        # count
        i += 1
        if i % 100000 == 0:
            print i
    arange = (arange_min, arange_max)
    brange = (brange_min, brange_max)
    print arange
    print brange
    # arange = (-2.0, 2.0)
    # brange = (-1.0, 1.0)

    # go through, line by line
    print "Filling out the image"
    for coord, count in data.iteritems():
        # write out the data
        x = round((coord[0]+arange[0])/(arange[1]-arange[0])*640)%640
        y = round((coord[1]+brange[0])/(brange[1]-brange[0])*480)%480
        img[y][x] = 2*count
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
