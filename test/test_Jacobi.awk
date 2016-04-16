#!/bin/awk -f
# $ awk -f ../src/PDBReader.awk -f test_PDBRead.awk

BEGIN {
    MATRIX[0,0] = 2.0
    MATRIX[0,1] = 3.0
    MATRIX[1,0] = 3.0
    MATRIX[0,2] = 5.0
    MATRIX[2,0] = 5.0
    MATRIX[0,3] = 7.0
    MATRIX[3,0] = 7.0
    MATRIX[1,1] = 1.0
    MATRIX[1,2] = 11.0
    MATRIX[2,1] = 11.0
    MATRIX[1,3] = 0.0
    MATRIX[3,1] = 0.0
    MATRIX[2,2] = 2.0
    MATRIX[2,3] = 0.0
    MATRIX[3,2] = 0.0
    MATRIX[3,3] = 2.0

    SolveJacobi(MATRIX, 4, EIGVAL, EIGVEC)

    print "EigenValues are " EIGVAL[0] " " EIGVAL[1] " " EIGVAL[2] " " EIGVAL[3]
    print "EigenVectors are "
    print EIGVEC[0,0] " " EIGVEC[0,1] " " EIGVEC[0,2] " " EIGVEC[0,3]
    print EIGVEC[1,0] " " EIGVEC[1,1] " " EIGVEC[1,2] " " EIGVEC[1,3]
    print EIGVEC[2,0] " " EIGVEC[2,1] " " EIGVEC[2,2] " " EIGVEC[2,3]
    print EIGVEC[3,0] " " EIGVEC[3,1] " " EIGVEC[3,2] " " EIGVEC[3,3]

    minEigenVec(MATRIX, 4, MINEIGVEC)

    print "min"
    print MINEIGVEC[0] " " MINEIGVEC[1] " " MINEIGVEC[2] " " MINEIGVEC[3] " " 
}
