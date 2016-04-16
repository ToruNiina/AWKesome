#!/usr/bin/awk -f
# AWKesome copyright (c) 2016 Toru Niina
# desctiption
#   generate best fit structure
# How to use it
#   run following way.
#   $ awk -f Trigonometric.awk -f VectorOperation.awk -f utils.awk \
#         -f MatrixOperation.awk -f JacobiMethod.awk -f BestFit.awk \
#         -f your_awesome_awk_script.awk

function BestFit(Structure, Reference, Fitted, N) {
    zeroing(Structure, ZeroStr, N)
    zeroing(Reference, ZeroRef, N)

    for(i=0;i<N;i++) {
        Avec[i,"X"] = ZeroRef[i,"X"] + ZeroStr[i,"X"]
        Avec[i,"Y"] = ZeroRef[i,"Y"] + ZeroStr[i,"Y"]
        Avec[i,"Z"] = ZeroRef[i,"Z"] + ZeroStr[i,"Z"]

        Bvec[i,"X"] = ZeroRef[i,"X"] - ZeroStr[i,"X"]
        Bvec[i,"Y"] = ZeroRef[i,"Y"] - ZeroStr[i,"Y"]
        Bvec[i,"Z"] = ZeroRef[i,"Z"] - ZeroStr[i,"Z"]
    }

    gen_Bmat(Avec, Bvec, Bmat, N)
    minEigenVec(Bmat, 4, BEigVec)
    gen_Rmat(BEigVec, Rmat)

    for(i=0;i<N;i++) {
        pos[0] = ZeroStr[i,"X"]
        pos[1] = ZeroStr[i,"Y"]
        pos[2] = ZeroStr[i,"Z"]

        mat3_vecmul(Rmat, pos, rot)

        Fitted[i,"X"] = rot[0]
        Fitted[i,"Y"] = rot[1]
        Fitted[i,"Z"] = rot[2]
    }

    return
}

function zeroing(Struct, Zeroed, N) {
    str_sum[0] = 0.0
    str_sum[1] = 0.0
    str_sum[2] = 0.0
    for(i=0;i<N;i++) {
        str_sum[0] = str_sum[0] + Struct[i,"X"]
        str_sum[1] = str_sum[1] + Struct[i,"Y"]
        str_sum[2] = str_sum[2] + Struct[i,"Z"]
    }
    vec_div(str_sum, N, mean)

    for(i=0;i<N;i++) {
        Zeroed[i,"X"] = Struct[i,"X"] - mean[0]
        Zeroed[i,"Y"] = Struct[i,"Y"] - mean[1]
        Zeroed[i,"Z"] = Struct[i,"Z"] - mean[2]
    }
    return
}

function gen_Bmat(AVec, BVec, Bmat, N) {
    Bmat[0,0] = 0.0
    Bmat[0,1] = 0.0
    Bmat[0,2] = 0.0
    Bmat[0,3] = 0.0
    Bmat[1,1] = 0.0
    Bmat[1,2] = 0.0
    Bmat[1,3] = 0.0
    Bmat[2,2] = 0.0
    Bmat[2,3] = 0.0
    Bmat[3,3] = 0.0

    for(i=0;i<N;i++) {
        ai[0] = AVec[i,"X"]
        ai[1] = AVec[i,"Y"]
        ai[2] = AVec[i,"Z"]

        bi[0] = BVec[i,"X"]
        bi[1] = BVec[i,"Y"]
        bi[2] = BVec[i,"Z"]

        Bmat[0,0] = Bmat[0,0] + vec_len_sq(bi)
        Bmat[0,1] = Bmat[0,1] + (ai[2]*bi[1]) - (ai[1]*bi[2])
        Bmat[0,2] = Bmat[0,2] + (ai[0]*bi[2]) - (ai[2]*bi[0])
        Bmat[0,3] = Bmat[0,3] + (ai[1]*bi[0]) - (ai[0]*bi[1])
        Bmat[1,1] = Bmat[1,1] + (bi[0]*bi[0]) + (ai[1]*ai[1]) + (ai[2]*ai[2])
        Bmat[1,2] = Bmat[1,2] + (bi[0]*bi[1]) - (ai[0]*ai[1])
        Bmat[1,3] = Bmat[1,3] + (bi[0]*bi[2]) - (ai[0]*ai[2])
        Bmat[2,2] = Bmat[2,2] + (ai[0]*ai[0]) + (bi[1]*bi[1]) + (ai[2]*ai[2])
        Bmat[2,3] = Bmat[2,3] + (bi[1]*bi[2]) - (ai[1]*ai[2])
        Bmat[3,3] = Bmat[3,3] + (ai[0]*ai[0]) + (ai[1]*ai[1]) + (bi[2]*bi[2])
    }

    Bmat[0,0] = Bmat[0,0] / N
    Bmat[0,1] = Bmat[0,1] / N
    Bmat[0,2] = Bmat[0,2] / N
    Bmat[0,3] = Bmat[0,3] / N
    Bmat[1,1] = Bmat[1,1] / N
    Bmat[1,2] = Bmat[1,2] / N
    Bmat[1,3] = Bmat[1,3] / N
    Bmat[2,2] = Bmat[2,2] / N
    Bmat[2,3] = Bmat[2,3] / N
    Bmat[3,3] = Bmat[3,3] / N

    Bmat[1,0] = Bmat[0,1]
    Bmat[2,0] = Bmat[0,2]
    Bmat[3,0] = Bmat[0,3]
    Bmat[2,1] = Bmat[1,2]
    Bmat[3,1] = Bmat[1,3]
    Bmat[3,2] = Bmat[2,3]
    return 
}

function gen_Rmat(Quat, Ret) {
    Ret[0,0] = 2.0 * Quat[0] * Quat[0] + 2.0 * Quat[1] * Quat[1] - 1.0
    Ret[0,1] = 2.0 * Quat[1] * Quat[2] - 2.0 * Quat[0] * Quat[3]
    Ret[0,2] = 2.0 * Quat[1] * Quat[3] + 2.0 * Quat[0] * Quat[2]

    Ret[1,0] = 2.0 * Quat[1] * Quat[2] + 2.0 * Quat[0] * Quat[3]
    Ret[1,1] = 2.0 * Quat[0] * Quat[0] + 2.0 * Quat[2] * Quat[2] - 1.0
    Ret[1,2] = 2.0 * Quat[2] * Quat[3] - 2.0 * Quat[0] * Quat[1]

    Ret[2,0] = 2.0 * Quat[1] * Quat[3] - 2.0 * Quat[0] * Quat[2]
    Ret[2,1] = 2.0 * Quat[2] * Quat[3] + 2.0 * Quat[0] * Quat[1]
    Ret[2,2] = 2.0 * Quat[0] * Quat[0] + 2.0 * Quat[3] * Quat[3] - 1.0
}
