#!/bin/awk -f
# $ awk -f ../src/Trigonometric.awk -f test_Trigo.awk

BEGIN {
    print "pi = " atan2(0, -0)

    print "acos(0) = " acos(0)
    print "acos(sqrt(2)/2)" acos(sqrt(2)/2) / atan2(0,-0)
    print "acos(sqrt(3)/2)" acos(sqrt(3)/2) / atan2(0,-0)

    print "asin(0) = " asin(0)
    print "asin(sqrt(2)/2)" asin(sqrt(2)/2) / atan2(0,-0)
    print "asin(sqrt(3)/2)" asin(sqrt(3)/2) / atan2(0,-0)
}
