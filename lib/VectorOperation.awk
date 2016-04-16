#!/usr/bin/awk -f
# AWKesome Copyright (c) 2016 Toru Niina
# desctiption
#   in AWKesome, vector is represented as an array that has 3 values.
#   and the array must be accessible with index 0,1,2.
# How to use it
#   run following way.
#   $ awk -f Trigonometric.awk -f VectorOperation.awk \
#         -f your_awesome_awk_script.awk

function vec_len_sq(vec) {
    return vec[0]^2 + vec[1]^2 + vec[2]^2
}

function vec_len(vec) {
    return sqrt(vec_len_sq(vec))
}

function vec_copy(lhs, rhs) {
    rhs[0] = lhs[0]
    rhs[1] = lhs[1]
    rhs[2] = lhs[2]
    return
}

function vec_add(lhs, rhs, ret) {
    ret[0] = lhs[0] + rhs[0]
    ret[1] = lhs[1] + rhs[1]
    ret[2] = lhs[2] + rhs[2]
    return 
}

function vec_sub(lhs, rhs, ret) {
    ret[0] = lhs[0] - rhs[0]
    ret[1] = lhs[1] - rhs[1]
    ret[2] = lhs[2] - rhs[2]
}

function vec_mul(vec, val, ret) {
    ret[0] = lhs[0] * val
    ret[1] = lhs[1] * val
    ret[2] = lhs[2] * val
}

function vec_div(vec, val, ret) {
    ret[0] = lhs[0] / val
    ret[1] = lhs[1] / val
    ret[2] = lhs[2] / val
}

function vec_dot(lhs, rhs) {
    return lhs[0] * rhs[0] + lhs[1] * rhs[1] + lhs[2] * rhs[2]
}

function vec_cross(lhs, rhs, ret) {
    ret[0] = lhs[1] * rhs[2] - lhs[2] * rhs[1]
    ret[1] = lhs[2] * rhs[0] - lhs[0] * rhs[2]
    ret[2] = lhs[0] * rhs[1] - lhs[1] * rhs[0]
}

function vec_angle(lhs, rhs) {
    vec_div(lhs, vec_len(lhs), trimmed_lhs)
    vec_div(rhs, vec_len(rhs), trimmed_rhs)
    dot_prod=vec_dot(trimmed_lhs, trimmed_rhs)
    return acos(dot_prod)
}

function vec_print(vec) {
    printf vec[0] " " vec[1] " " vec[2] " "
}
