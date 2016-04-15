#!/bin/bash
: "run test_Trigonometric" && {
    echo "run test_Trigonometric"
    awk -f ../src/Trigonometric.awk -f test_Trigo.awk
    echo "end."
}

: "run test_Vector" && {
    echo "run test_Vector"
    awk -f ../src/Trigonometric.awk -f ../src/VectorOperation.awk -f test_Vector.awk
    echo "end."
}
