# AWKesome (c) Toru Niina, 2016
# desctiption
#   some trigonometric functions.
#   inverse trigonometric function returns degree. not radian.
# How to use it
#   run following way.
#   $ awk -f Trigonometric.awk -f your_awesome_awk_script.awk

function tan(theta) {
    return sin(theta) / cos(theta)
}

function acos(x) {
    return atan2(sqrt(1-x*x), x)
}

function asin(x) {
    return atan2(x, sqrt(1-x*x))
}

function atan(x) {
    return atan2(x, 1.0)
}
