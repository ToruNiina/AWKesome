#!/bin/awk -f
# $ awk -f ../src/PDBReader.awk -f test_PDBRead.awk

BEGIN {
    printf "reading pdb file...  "
    PDBread("sh3.pdb_example", SH3, size)
    print "done."

    print "there are " size["MODEL"] " models in sh3_example."
    print "there are " size["PARTICLE"] " particles in one model."

    print "Information of the first particle of model 1 is below."
    print "residue name is : " SH3[1,1,"RESIDUE"]
    print "atom name is    : " SH3[1,1,"ATOM"]
    print "chain name is   : " SH3[1,1,"CHAIN"]
    print "residue id is   : " SH3[1,1,"RESID"]
    print "x coordinate is : " SH3[1,1,"X"]
    print "y coordinate is : " SH3[1,1,"Y"]
    print "z coordinate is : " SH3[1,1,"Z"]

    print "Information of the first particle of model 2 is below."
    print "residue name is : " SH3[2,1,"RESIDUE"]
    print "atom name is    : " SH3[2,1,"ATOM"]
    print "chain name is   : " SH3[2,1,"CHAIN"]
    print "residue id is   : " SH3[2,1,"RESID"]
    print "x coordinate is : " SH3[2,1,"X"]
    print "y coordinate is : " SH3[2,1,"Y"]
    print "z coordinate is : " SH3[2,1,"Z"]
}
