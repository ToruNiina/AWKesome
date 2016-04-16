#!/usr/bin/awk -f
# AWKesome Copyright (c) 2016 Toru Niina
# desctiption
#   in AWKesome, Matrix is represented as an pseudo-multidimentional array.
#   (mat[0,0] mat[0,1])
#   (mat[1,0] mat[1,1])
#   AWKesome supports NxM dimentional and 3x3 dimentional matrix.
# How to use it
#   run following way.
#   $ awk -f Trigonometric.awk -f VectorOperation.awk -f MatrixOperation.awk\
#         -f your_awesome_awk_script.awk

function matNM_copy(lhs, ret, N, M) {
    for(i=0;i<N;i++) {
        for(j=0;j<M;j++) {
            ret[i,j] = lhs[i,j]
        }
    }
}

function matNM_print(mat, N, M) {
    for(i=0;i<N;i++) {
        for(j=0;j<M;j++) {
            printf mat[i,j] " "
        }
        print ""
    }
}

function matNM_add(lhs, rhs, ret, N, M) {
    for(i=0;i<N;i++) {
        for(j=0;j<M;j++) {
            ret[i,j] = lhs[i,j] + rhs[i,j]
        }
    }
}

function matNM_sub(lhs, rhs, ret, N, M) {
    for(i=0;i<N;i++) {
        for(j=0;j<M;j++) {
            ret[i,j] = lhs[i,j] - rhs[i,j]
        }
    }
}

function matNM_sclmul(mat, scl, ret, N, M) {
    for(i=0;i<N;i++) {
        for(j=0;j<M;j++) {
            ret[i,j] = mul[i,j] * scl
        }
    }
}

function matNM_scldiv(mat, scl, ret, N, M) {
    for(i=0;i<N;i++) {
        for(j=0;j<M;j++) {
            ret[i,j] = mul[i,j] / scl
        }
    }
}

# for LxM * MxN
function matLMN_mul(lhs, rhs, ret, L, M, N) {
    for(i=0;i<L;i++) {
        for(j=0;j<N;j++) {
            sum=0.0
            for(k=0;k<M;k++) {
                sum = sum + lhs[i,k] * rhs[k,j]
            }
            ret[i,j] = sum
        }
    }
}

function mat_transpose(lhs, ret, N, M) {
    for(i=0;i<N;i++) {
        for(j=0;j<M;j++) {
            ret[j,i] = lhs[i,j]
        }
    }
}

function mat3_col_vec(mat, i, ret) {
    ret[0] = mat[0,i]
    ret[1] = mat[1,i]
    ret[2] = mat[2,i]
}

function mat3_row_vec(mat, i, ret) {
    ret[0] = mat[i,0]
    ret[1] = mat[i,0]
    ret[2] = mat[i,0]
}

function mat3_add(lhs, rhs, ret) {
    ret[0,0] = lhs[0,0] + rhs[0,0]
    ret[0,1] = lhs[0,1] + rhs[0,1]
    ret[0,2] = lhs[0,2] + rhs[0,2]
    ret[1,0] = lhs[1,0] + rhs[1,0]
    ret[1,1] = lhs[1,1] + rhs[1,1]
    ret[1,2] = lhs[1,2] + rhs[1,2]
    ret[2,0] = lhs[2,0] + rhs[2,0]
    ret[2,1] = lhs[2,1] + rhs[2,1]
    ret[2,2] = lhs[2,2] + rhs[2,2]
}

function mat3_sub(lhs, rhs, ret) {
    ret[0,0] = lhs[0,0] - rhs[0,0]
    ret[0,1] = lhs[0,1] - rhs[0,1]
    ret[0,2] = lhs[0,2] - rhs[0,2]
    ret[1,0] = lhs[1,0] - rhs[1,0]
    ret[1,1] = lhs[1,1] - rhs[1,1]
    ret[1,2] = lhs[1,2] - rhs[1,2]
    ret[2,0] = lhs[2,0] - rhs[2,0]
    ret[2,1] = lhs[2,1] - rhs[2,1]
    ret[2,2] = lhs[2,2] - rhs[2,2]
}

function mat3_sclmul(mat, scl, ret) {
    ret[0,0] = mat[0,0] * scl
    ret[0,1] = mat[0,1] * scl
    ret[0,2] = mat[0,2] * scl
    ret[1,0] = mat[1,0] * scl
    ret[1,1] = mat[1,1] * scl
    ret[1,2] = mat[1,2] * scl
    ret[2,0] = mat[2,0] * scl
    ret[2,1] = mat[2,1] * scl
    ret[2,2] = mat[2,2] * scl
}

function mat3_scldiv(mat, scl, ret) {
    ret[0,0] = mat[0,0] / scl
    ret[0,1] = mat[0,1] / scl
    ret[0,2] = mat[0,2] / scl
    ret[1,0] = mat[1,0] / scl
    ret[1,1] = mat[1,1] / scl
    ret[1,2] = mat[1,2] / scl
    ret[2,0] = mat[2,0] / scl
    ret[2,1] = mat[2,1] / scl
    ret[2,2] = mat[2,2] / scl
}

function mat3_matmul(lhs, rhs, ret) {
    ret[0,0] = lhs[0,0] * rhs[0,0] + lhs[0,1] * rhs[1,0] + lhs[0,2] * rhs[2,0]
    ret[0,1] = lhs[0,0] * rhs[0,1] + lhs[0,1] * rhs[1,1] + lhs[0,2] * rhs[2,1]
    ret[0,2] = lhs[0,0] * rhs[0,2] + lhs[0,1] * rhs[1,2] + lhs[0,2] * rhs[2,2]
    ret[1,0] = lhs[1,0] * rhs[0,0] + lhs[1,1] * rhs[1,0] + lhs[1,2] * rhs[2,0]
    ret[1,1] = lhs[1,0] * rhs[0,1] + lhs[1,1] * rhs[1,1] + lhs[1,2] * rhs[2,1]
    ret[1,2] = lhs[1,0] * rhs[0,2] + lhs[1,1] * rhs[1,2] + lhs[1,2] * rhs[2,2]
    ret[2,0] = lhs[2,0] * rhs[0,0] + lhs[2,1] * rhs[1,0] + lhs[2,2] * rhs[2,0]
    ret[2,1] = lhs[2,0] * rhs[0,1] + lhs[2,1] * rhs[1,1] + lhs[2,2] * rhs[2,1]
    ret[2,2] = lhs[2,0] * rhs[0,2] + lhs[2,1] * rhs[1,2] + lhs[2,2] * rhs[2,2]
}

function mat3_vecmul(mat, vec, ret) {
    ret[0] = mat[0,0] * vec[0] + lhs[0,1] * vec[1] + mat[0,2] * vec[2]
    ret[1] = mat[1,0] * vec[0] + lhs[1,1] * vec[1] + mat[1,2] * vec[2]
    ret[2] = mat[2,0] * vec[0] + lhs[2,1] * vec[1] + mat[2,2] * vec[2]
}

function vec_mat3mul(vec, mat, ret) {
    ret[0] = mat[0,0] * vec[0] + lhs[1,0] * vec[1] + mat[2,0] * vec[2]
    ret[1] = mat[0,1] * vec[0] + lhs[1,1] * vec[1] + mat[2,1] * vec[2]
    ret[2] = mat[0,2] * vec[0] + lhs[1,2] * vec[1] + mat[2,2] * vec[2]
}

