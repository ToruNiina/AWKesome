#!/usr/bin/awk -f
# AWKesome copyright (c) 2016 Toru Niina
# desctiption
#   Find eigen value and eigen vector. 
#   For real symmetric matrix only.
# How to use it
#   run following way.
#   $ awk -f utils.awk -f MatrixOperation.awk -f JacobiMethod.awk \
#         -f your_awesome_awk_script.awk

function minEigenVec(mat, N, EVec) {
    SolveJacobi(mat, N, EIGVAL, EIGVEC)

    minindex=0
    minval=EIGVAL[0]
    for(i=1;i<N;i++) {
        if(minval > EIGVAL[i]) {
            minval = EIGVAL[i]
            minindex=i
        }
    }

    for(j=0;j<N;j++) {
        EVec[j] = EIGVEC[minindex,j]
    }
}

function SolveJacobi(mat, N, EVal, EVec) {
    for(ip=0;ip<N;++ip) {
        for(jp=0;jp<N;++jp) {
            if(ip==jp) {
                Ps[ip,jp] = 1.0
            }
            else {
                Ps[ip,jp] = 0.0
            }
        }
    }
    matNM_copy(mat, target, N, N)

    for(Jloop=0; Jloop<100;Jloop++) {
        get_max_element(target, N, INDEX)
        if(abs(target[INDEX["ROW"], INDEX["COL"]]) < 0.00000000001) {
            break
        }
        alpha=(target[INDEX["ROW"], INDEX["ROW"]] - target[INDEX["COL"], INDEX["COL"]]) / 2
        beta= -1 * target[INDEX["ROW"], INDEX["COL"]]
        gamma=abs(alpha) / sqrt(alpha^2 + beta^2)
        sign=1.0
        if(alpha * beta < 0.0) {
            sign = -1.0
        }
        cosv = sqrt((1.0 + gamma) * 0.5)
        sinv = sqrt((1.0 - gamma) * 0.5) * sign

        for(ipp=0;ipp<N;++ipp) {
            for(jpp=0;jpp<N;++jpp) {
                if(ipp==jpp) {
                    PPri[ipp,jpp] = 1.0
                }
                else {
                    PPri[ipp,jpp] = 0.0
                }
            }
        }

        PPri[INDEX["ROW"], INDEX["ROW"]] = cosv
        PPri[INDEX["ROW"], INDEX["COL"]] = sinv
        PPri[INDEX["COL"], INDEX["ROW"]] = -1.0 * sinv
        PPri[INDEX["COL"], INDEX["COL"]] = cosv

        mat_transpose(PPri, PProx, N, N)

        matLMN_mul(PProx, target, tmp1, N, N, N)
        matLMN_mul(tmp1, PPri, target, N, N, N)

        target[INDEX["ROW"], INDEX["COL"]] = 0.0
        target[INDEX["COL"], INDEX["ROW"]] = 0.0


        matLMN_mul(Ps, PPri, temp, N, N, N)
        matNM_copy(temp, Ps, N, N)
    }

    for(evi=0;evi<N;evi++) {
        EVal[evi] = target[evi,evi]
        for(evj=0;evj<N;evj++) {
            EVec[evi,evj] = Ps[evj,evi]
        }
    }
}

function get_max_element(mat, N, EleIndex) {
    EleIndex["COL"] = 1
    EleIndex["ROW"] = 0
    value = abs(mat[EleIndex["ROW"], EleIndex["COL"]])

    for(i=0; i<N-1; i++) {
        for(j=i+1; j<N; j++) {
            if(value < abs(mat[i,j])) {
                EleIndex["ROW"] = i
                EleIndex["COL"] = j
                value = abs(mat[j,i])
            }
        }
    }
    return
}
