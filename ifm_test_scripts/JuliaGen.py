class JuliaSetGenerator:
    
    def __init__(self, z_c):
        self.z_c = z_c
        self.MAX_ITER = 127
    
    def iterate(self, z_i):
        z_j = z_i**2 + self.z_c
        return z_j

    def test_point(self, z_0):
        unbound_iteration = 0
        z_i = z_0
        while abs(z_i) < 2 and unbound_iteration < self.MAX_ITER:
            z_i = self.iterate(z_i)
            unbound_iteration += 1

        if abs(z_i) < 2:
            return -1
        else:
            return unbound_iteration
