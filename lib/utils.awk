# AWKesome (c) Toru Niina, 2016
# desctiption
#   Utility functions. 
# How to use it
#   run following way.
#   $ awk -f utils.awk -f your_awesome_awk_script.awk

function abs(x) {
    if(x < 0.0) {
        return -x
    }
    else {
        return x
    }
}
