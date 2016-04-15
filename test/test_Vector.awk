#!/bin/awk -f

BEGIN {
    vec1[0] = 1.0
    vec1[1] = 0.0
    vec1[2] = 0.0
    printf "vector 1 = ("
    vec_print(vec1)
    print ")"

    vec2[0] = 0.0
    vec2[1] = 1.0
    vec2[2] = 0.0
    printf "vector 2 = (" 
    vec_print(vec2)
    print ")"

    print  "length of vector 1  : " vec_len(vec1)
    print  "length of vector 2  : " vec_len(vec2)
    print  "dot product of them : " vec_dot(vec1, vec2)
    printf "cross product of them : "
    vec_cross(vec1, vec2, vec3)
    vec_print(vec3)
    print ""
    printf "vector 1 + vector 2 : "
    vec_add(vec1, vec2, vec3)
    vec_print(vec3)
    print ""
    printf "vector 1 - vector 2 : "
    vec_sub(vec1, vec2, vec3)
    vec_print(vec3)
    print ""
    printf "vector 1 * 2        : "
    vec_mul(vec1, 2.0, vec3)
    vec_print(vec3)
    print ""
    printf "vector 1 / 2        : "
    vec_div(vec1, 2.0, vec3)
    vec_print(vec3)
    print ""
    printf "the angle between 1 & 2 : "
    printf vec_angle(vec1, vec2)
    print ""
}
