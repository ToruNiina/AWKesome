#!/usr/bin/awk -f
# AWKesome Copyright (c) 2016 Toru Niina
# desctiption
#   Calculate RMSD from movie file. The reference pdb structure is required.
# How to use it
#   run following way.
#   $ awk -f Trigonometric.awk -f VectorOperation.awk -f PDBReader.awk \
#         -f utils.awk -f MatrixOperation.awk -f JacobiMethod.awk \
#         -f BestFit.awk -f RMSDCalculator.awk -v ref=reference.pdb
#         -v movie=result.movie

BEGIN{
    PDBread(ref, REFDATA, REFSIZE)
    for(i_ref=0; i_ref<REFSIZE["PARTICLE"]; i_ref++) {
        REFERENCE[i_ref, "X"] = REFDATA[0,i_ref,"X"]
        REFERENCE[i_ref, "Y"] = REFDATA[0,i_ref,"Y"]
        REFERENCE[i_ref, "Z"] = REFDATA[0,i_ref,"Z"]
    }

    PDBread(movie, MOVIEDATA, MOVIESIZE)
    if(MOVIESIZE["PARTICLE"] != REFSIZE["PARTICLE"]) {
        print ref " and " movie " contains different structure"
        exit
    }
 
    print "# model-index, RMSD"
    for(i_model=1; i_model<MOVIESIZE["MODEL"]; i_model++) {
        for(i_part=0; i_part<MOVIESIZE["PARTICLE"]; i_part++) {
            SNAPSHOT[i_part, "X"] = MOVIEDATA[i_model,i_part,"X"]
            SNAPSHOT[i_part, "Y"] = MOVIEDATA[i_model,i_part,"Y"]
            SNAPSHOT[i_part, "Z"] = MOVIEDATA[i_model,i_part,"Z"]
        }

        BestFit(SNAPSHOT, REFERENCE, FITTEDSTR, REFSIZE["PARTICLE"])
        print i_model " " calc_RMSD(FITTEDSTR, REFERENCE, REFSIZE["PARTICLE"])
    }
}

function calc_RMSD(fitted_structure, rmsd_reference, num_particle) {
    rmsd=0.0
    for(i=0; i<num_particle; i++) {
        lhs[0] = fitted_structure[i, "X"]
        lhs[1] = fitted_structure[i, "Y"]
        lhs[2] = fitted_structure[i, "Z"]

        rhs[0] = rmsd_reference[i, "X"]
        rhs[1] = rmsd_reference[i, "Y"]
        rhs[2] = rmsd_reference[i, "Z"]

        vec_sub(lhs, rhs, dpos)
        rmsd = rmsd + vec_len_sq(dpos)
    }
    return sqrt(rmsd / num_particle)
}
