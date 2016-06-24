#!/bin/sh

: "contact map" && {
    sh wrapper.sh pdb vector -f ../src/ContactMap.awk threshold=6.5 pdbfile="../data/sh3_native.pdb" model=0
}

: "RMSD" && {
    sh wrapper.sh pdb bestfit ../src/RMSDCalculator.awk ref="../data/sh3_native.pdb" movie="../data/sh3_native.movie" > sh3_rmsd.dat
}
