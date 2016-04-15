#!/bin/bash
: "run test_Trigonometric" && {
    echo "=========== run test_Trigonometric ==========="
    awk -f ../lib/Trigonometric.awk -f test_Trigo.awk
    echo "~~~~~~~~~~~ end. ~~~~~~~~~~~"
}

echo ""

: "run test_Vector" && {
    echo "=========== run test_Vector ==========="
    awk -f ../lib/Trigonometric.awk -f ../lib/VectorOperation.awk -f test_Vector.awk
    echo "~~~~~~~~~~~ end. ~~~~~~~~~~~"
}

echo ""

: "run test_PDBRead" && {
    echo "=========== run test_PDBRead ==========="
    awk -f ../lib/PDBReader.awk -f test_PDBRead.awk
    echo "~~~~~~~~~~~ end. ~~~~~~~~~~~"
}
