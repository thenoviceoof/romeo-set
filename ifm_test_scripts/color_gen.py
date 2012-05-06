#!/usr/bin/python

import pygtk
pygtk.require("2.0")
import gtk

import os
import pickle

from PIL import Image

BITS = 7
CAP = 2**BITS

DEFAULT_SIZE = (640,480)

# caching
def load_img(window, size, const):
    if not os.path.exists("cache"):
        os.makedirs("cache")
    try:
        f = open("cache/%s.pickle" % (window, size, const).__hash__())
        print("Loading up cached fractal...")
        a = pickle.load(f)
        print("Finished loading")
        return a
    except IOError:
        return None
def save_img(window, size, const, img):
    # convert img from numpy to normal lists
    if not os.path.exists("cache"):
        os.makedirs("cache")
    try:
        f = open("cache/%s.pickle" % (window, size, const).__hash__())
        print("Already cached, not going to write")
    except IOError:
        print("Writing fractal to the cache...")
        f = open("cache/%s.pickle" % (window, size, const).__hash__(), "w")
        pickle.dump(img, f)
        print("Finished writing")

# fractal generator
def generate_fractal(window=((2.6,2.0),(-2.6,-2.0)), size=(640,480), const=0):
    img = load_img(window, size, const)
    if not(img is None):
        return img
    print("Generating fractal...")
    img = [[0 for i in range(size[0])] for j in range(size[1])]
    for x in range(size[1]):
        print "row %d" % x
        for y in range(size[0]):
            py = (window[0][0] - window[1][0])*(float(x)/size[0]) + window[1][0]
            px = (window[0][1] - window[1][1])*(float(y)/size[1]) + window[1][1]
            p = px + py*1j
            it = 0
            while abs(p) < 2 and it < CAP - 1:
                p = p ** 2 + const
                it += 1
            img[x][y] = it
    save_img(window, size, const, img)
    return img

# colorizer
def color_img(counts, d):
    size = (len(counts[0]), len(counts))
    img = [[[0 for k in range(3)] for i in range(size[0])]
           for j in range(size[1])]
    for x in range(size[1]):
        for y in range(size[0]):
            c = counts[x][y]
            color = d[c]
            img[x][y][0] = color[0]
            img[x][y][1] = color[1]
            img[x][y][2] = color[2]
    return img

def linear_color_map(begin=(0,0,0), end=(255,0,0)):
    def crange(a, b, t):
        return (b-a)*t + a
    d = {}
    for i in range(CAP):
        d[i] = (crange(begin[0], end[0], float(i)/CAP),
                crange(begin[1], end[1], float(i)/CAP),
                crange(begin[2], end[2], float(i)/CAP))
    return d
def sqrt_color_map(begin=(0,0,0), end=(255,0,0)):
    def crange(a, b, t):
        return (b-a)*t + a
    d = {}
    for i in range(CAP):
        ii = round(((float(i)/CAP)**0.5 ) * CAP)
        d[i] = (crange(begin[0], end[0], float(ii)/CAP),
                crange(begin[1], end[1], float(ii)/CAP),
                crange(begin[2], end[2], float(ii)/CAP))
    return d

def convert_string(img):
    s = ""
    for row in img:
        for elem in row:
            for c in elem:
                s += str(chr(int(c)))
    return s

class Base:
    def delete_event(self, widget, data=None):
        return False

    def destroy(self, widget, data=None):
        print("Goodbye!")
        gtk.main_quit()

    def build_color_map(self):
        cr = self.color_r.get_vector()
        cg = self.color_g.get_vector()
        cb = self.color_b.get_vector()
        d = {}
        for i in range(CAP):
            d[i] = (round(cr[i]/4),
                    round(cg[i]/4),
                    round(cb[i]/4))
        return d

    def refractal(self, widget, data=None):
        print("Recalculating fractal geometry")
        real = self.realin.get_value()
        comp = self.compin.get_value()
        self.fractal = generate_fractal(const = real+comp*1j)
        self.recolor(None)
    def recolor(self, widget, data=None):
        print self.color_r.get_vector()
        print("Recalculating fractal colormap")
        img = color_img(self.fractal, self.build_color_map())
        s = convert_string(img)
        buf = gtk.gdk.pixbuf_new_from_data(s, gtk.gdk.COLORSPACE_RGB,
                                           False, 8,
                                           self.size[0], self.size[1], 3*640)
        self.img.set_from_pixbuf(buf)

    def __init__(self):
        self.img = gtk.Image()
        self.size = DEFAULT_SIZE

        # color curves
        self.color_r = gtk.Curve()
        self.color_r.set_range(0, CAP, 0, 2**10)
        self.color_g = gtk.Curve()
        self.color_g.set_range(0, CAP, 0, 2**10)
        self.color_b = gtk.Curve()
        self.color_b.set_range(0, CAP, 0, 2**10)

        # adjustment tools
        realadj = gtk.Adjustment(0.0, -1.0, 1.0, 0.01)
        compadj = gtk.Adjustment(0.0, -1.0, 1.0, 0.01)
        self.realin = gtk.SpinButton(adjustment=realadj, digits=2)
        self.compin = gtk.SpinButton(adjustment=compadj, digits=2)

        # buttons
        self.recolorb = gtk.Button("Recalculate Colormap")
        self.refractalb = gtk.Button("Recalculate Fractal")

        self.window = gtk.Window(gtk.WINDOW_TOPLEVEL)

        # signals
        self.window.connect("delete_event", self.delete_event)
        self.window.connect("destroy", self.destroy)

        self.recolorb.connect("clicked", self.recolor)
        self.refractalb.connect("clicked", self.refractal)

        # packing
        self.const_input_pane = gtk.HBox()
        self.const_input_pane.pack_start(self.realin)
        self.const_input_pane.pack_start(self.compin)

        self.side_pane = gtk.VBox()
        self.side_pane.pack_start(self.color_r)
        self.side_pane.pack_start(self.color_g)
        self.side_pane.pack_start(self.color_b)
        self.side_pane.pack_start(self.const_input_pane)
        self.side_pane.pack_start(self.recolorb)
        self.side_pane.pack_start(self.refractalb)

        self.main_pane = gtk.HBox()
        self.main_pane.pack_start(self.img)
        self.main_pane.pack_start(self.side_pane)

        self.window.add(self.main_pane)

        # showing things
        self.color_r.show()
        self.color_g.show()
        self.color_b.show()

        self.realin.show()
        self.compin.show()
        self.const_input_pane.show()

        self.img.show()
        self.recolorb.show()
        self.refractalb.show()

        self.side_pane.show()
        self.main_pane.show()
        self.window.show()

        # calculate the initial fractal
        self.refractal(None)

    def main(self):
        gtk.main()

if __name__ == "__main__":
    base = Base()
    base.main()
