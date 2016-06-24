#!/usr/bin/awk -f
# AWKesome Copyright (c) 2016 Toru Niina
# desctiption
#   ContactMap make contact map from pdb file.
# How to use it
#   run following way.
#   $ awk -f Trigonometric.awk -f VectorOperation.awk -f PDBReader.awk \
#         -f ContactMap.awk -v threshold=6.5 -v model=1 -v pdbfile=hoge.pdb

BEGIN{
    print  "the definition of contact is " threshold
    printf "making contact map of " model "-th model in " pdbfile "..."
    print  ""
    PDBread(pdbfile, PDBDATA, PDBSIZE)

    for(i=1; i<PDBSIZE["PARTICLE"]; i++) {
        for(j=1; j<PDBSIZE["PARTICLE"]; j++) {
            lhs[0] = PDBDATA[model,i,"X"]
            lhs[1] = PDBDATA[model,i,"Y"]
            lhs[2] = PDBDATA[model,i,"Z"]

            rhs[0] = PDBDATA[model,j,"X"]
            rhs[1] = PDBDATA[model,j,"Y"]
            rhs[2] = PDBDATA[model,j,"Z"]

            write_pixel(is_contact(lhs, rhs, threshold))
        }
        print ""
    }
}

function distance(lhs, rhs) {
    vec_sub(lhs, rhs, dvec)
    return vec_len(dvec)
}

function is_contact(lhs, rhs, thr) {
    if(distance(lhs, rhs) < thr) {
        return 1
    }
    else {
        return 0
    }
}

function write_pixel(val) {
    if(val > 0) {
        printf "[]"
    }
    else {
        printf "  "
    }
}
