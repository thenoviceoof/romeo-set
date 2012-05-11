##################################################################
#test_ifm.py
#
#A python script for parsing and validating integration
#Test Bench dumps
#
#Author: Stephen Pratt
##################################################################


import test_ifm_utils
from JuliaGen import JuliaSetGenerator
import sys

if len(sys.argv) < 3:
	print 'Usage "test_ifm [model_sim_outfile] [epsilon]"'

#read in file
filename = sys.argv[1]
f = open(filename, 'r')

epsilon = sys.argv[2]

#read constants from header
header = f.readline().split()
if len(header) < 3:
	print 'Unparseable file header'

c_real = test_ifm_utils.from_fixed(int(header[1], 2))
c_img = test_ifm_utils.from_fixed(int(header[2], 2))

#create our floating point generator
j = JuliaSetGenerator(complex(c_real, c_img))

test_count = 0
wrong_count = 0

print "Commencing test"	
print "---------------"
print ""	
for line in f:
	data = line.split()
	if len(data) < 4:
		print "Unparseable entry at line %s"%data[0]

	#grab the point and its count from the file
	a = test_ifm_utils.from_fixed(int(data[1], 2))
	b = test_ifm_utils.from_fixed(int(data[2], 2))
	count = int(data[3])
	if count == 127:
		count = -1
	else:
		count += 1

	#compute our own count
	actual_count = j.test_point(complex(a, b))
	if abs(actual_count - count) > epsilon:
		print "Invalid count at line %s for value (%s, %s)"%(data[0], a, b)
		print "Actual count is %s vs recorded %s"%(actual_count, count)
		print ""
		wrong_count += 1
	test_count += 1

#report results
correct_count = (test_count - wrong_count)	
print "Test completed successfully"
if test_count != 0:		
	print "%s correct of %s tested (%s%% accuracy)"%(correct_count, test_count, (float(correct_count)/test_count))
else:
	print "No points tested."
