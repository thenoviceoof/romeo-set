#!/usr/bin/python

import pygtk
pygtk.require("2.0")
import gtk

import os
import pickle

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
        cr = [min(max(c, 0), 2**self.prec-1) for c in cr]
        cg = [min(max(c, 0), 2**self.prec-1) for c in cg]
        cb = [min(max(c, 0), 2**self.prec-1) for c in cb]
        d = {}
        for i in range(CAP):
            d[i] = (cr[i], cg[i], cb[i])
        return d
    def build_bmp_color_map(self):
        d = self.build_color_map()
        for i in range(CAP):
            d[i] = (round(d[i][0]/4) % 2**8,
                    round(d[i][1]/4) % 2**8,
                    round(d[i][2]/4) % 2**8)
        return d

    def gen_clut(self, widget, data=None):
        def convert_bin(num):
            s = ""
            for i in range(self.prec):
                s = str(int(round(num) % 2)) + s
                num /= 2
            return s
        d = self.build_color_map()
        ss = ["\"%s%s%s\"" % (convert_bin(d[i][0]),
                              convert_bin(d[i][1]),
                              convert_bin(d[i][2]))
              for i in range(CAP)]
        print len(ss)
        print ",\n".join(ss)

    def refractal(self, widget, data=None):
        print("Recalculating fractal geometry")
        real = self.realin.get_value()
        comp = self.compin.get_value()
        self.fractal = generate_fractal(const = real+comp*1j)
        self.recolor(None)
    def recolor(self, widget, data=None):
        print("Recalculating fractal colormap")
        img = color_img(self.fractal, self.build_bmp_color_map())
        s = convert_string(img)
        buf = gtk.gdk.pixbuf_new_from_data(s, gtk.gdk.COLORSPACE_RGB,
                                           False, 8,
                                           self.size[0], self.size[1], 3*640)
        self.img.set_from_pixbuf(buf)

    def set_ex1(self, widget, data=None):
        self.realin.set_value(-0.835)
        self.compin.set_value(-0.2321)
    def set_ex2(self, widget, data=None):
        self.realin.set_value(-0.4)
        self.compin.set_value(0.6)
    def set_ex3(self, widget, data=None):
        self.realin.set_value(-0.7018)
        self.compin.set_value(-0.3842)
    def set_ex4(self, widget, data=None):
        self.realin.set_value(-0.8)
        self.compin.set_value(0.156)

    def __init__(self):
        self.img = gtk.Image()
        self.size = DEFAULT_SIZE
        self.prec = 10

        # color curves
        self.color_r = gtk.Curve()
        self.color_r.set_range(0, CAP, 0, 2**self.prec)
        self.color_g = gtk.Curve()
        self.color_g.set_range(0, CAP, 0, 2**self.prec)
        self.color_b = gtk.Curve()
        self.color_b.set_range(0, CAP, 0, 2**self.prec)

        # adjustment tools
        realadj = gtk.Adjustment(0.0, -1.0, 1.0, 0.01)
        compadj = gtk.Adjustment(0.0, -1.0, 1.0, 0.01)
        self.realin = gtk.SpinButton(adjustment=realadj, digits=4)
        self.compin = gtk.SpinButton(adjustment=compadj, digits=4)

        # buttons
        self.recolorb = gtk.Button("Recalculate Colormap")
        self.refractalb = gtk.Button("Recalculate Fractal")
        self.clutb = gtk.Button("Output CLUT")

        self.ex1b = gtk.Button("Ex1")
        self.ex2b = gtk.Button("Ex2")
        self.ex3b = gtk.Button("Ex3")
        self.ex4b = gtk.Button("Ex4")

        self.window = gtk.Window(gtk.WINDOW_TOPLEVEL)

        # signals
        self.window.connect("delete_event", self.delete_event)
        self.window.connect("destroy", self.destroy)

        self.recolorb.connect("clicked", self.recolor)
        self.refractalb.connect("clicked", self.refractal)
        self.clutb.connect("clicked", self.gen_clut)

        self.ex1b.connect("clicked", self.set_ex1)
        self.ex2b.connect("clicked", self.set_ex2)
        self.ex3b.connect("clicked", self.set_ex3)
        self.ex4b.connect("clicked", self.set_ex4)

        # packing
        self.const_input_pane = gtk.HBox()
        self.const_input_pane.pack_start(self.realin)
        self.const_input_pane.pack_start(self.compin)

        self.example_pane = gtk.HBox()
        self.example_pane.pack_start(self.ex1b)
        self.example_pane.pack_start(self.ex2b)
        self.example_pane.pack_start(self.ex3b)
        self.example_pane.pack_start(self.ex4b)

        self.side_pane = gtk.VBox()
        self.side_pane.pack_start(self.color_r)
        self.side_pane.pack_start(self.color_g)
        self.side_pane.pack_start(self.color_b)
        self.side_pane.pack_start(self.const_input_pane)
        self.side_pane.pack_start(self.example_pane)
        self.side_pane.pack_start(self.recolorb)
        self.side_pane.pack_start(self.refractalb)
        self.side_pane.pack_start(self.clutb)

        self.main_pane = gtk.HBox()
        self.main_pane.pack_start(self.img, expand=False)
        self.main_pane.pack_start(self.side_pane, expand=True)

        self.window.add(self.main_pane)

        # showing things
        self.color_r.show()
        self.color_g.show()
        self.color_b.show()

        self.realin.show()
        self.compin.show()
        self.const_input_pane.show()

        self.ex1b.show()
        self.ex2b.show()
        self.ex3b.show()
        self.ex4b.show()
        self.example_pane.show()

        self.img.show()
        self.recolorb.show()
        self.refractalb.show()
        self.clutb.show()

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
