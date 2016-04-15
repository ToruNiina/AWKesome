#!/bin/bash
: "run test_Trigonometric" && {
    echo "=========== run test_Trigonometric ==========="
    awk -f ../src/Trigonometric.awk -f test_Trigo.awk
    echo "~~~~~~~~~~~ end. ~~~~~~~~~~~"
}

echo ""

: "run test_Vector" && {
    echo "=========== run test_Vector ==========="
    awk -f ../src/Trigonometric.awk -f ../src/VectorOperation.awk -f test_Vector.awk
    echo "~~~~~~~~~~~ end. ~~~~~~~~~~~"
}

echo ""

: "run test_PDBRead" && {
    echo "=========== run test_PDBRead ==========="
    awk -f ../src/PDBReader.awk -f test_PDBRead.awk
    echo "~~~~~~~~~~~ end. ~~~~~~~~~~~"
}
