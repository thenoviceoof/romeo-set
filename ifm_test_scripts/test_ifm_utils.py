##################################################################
#test_ifm_utils.py
#
#Some python functions useful when dealing with our IFMs
#
#Author: Stephen Pratt
##################################################################

NUM_BITS = 36
RADIX_SHIFT = 30
BIT_MASK = 0xFFFFFFFFC0000000
MASK_36	= 0xFFFFFFFFF
SIGN_BIT = 0x800000000

#Converts the value into a fixed point expression
def to_fixed(val):
	shifted = int((val * (1 << RADIX_SHIFT)))
        return shifted & MASK_36

#Takes a value in fixed point form and converts it to
#decimal
def from_fixed(val):
	sum = 0
	
	bit_mag = 1.0 / (2 << RADIX_SHIFT);

	for i in range(NUM_BITS-1):
	    bit_mag = bit_mag * 2

	    if (val & (1 << i)):
		sum += bit_mag
	
	bit_mag *= -2
	if(val & (1 << (NUM_BITS-1))):
		sum += bit_mag

	return sum
