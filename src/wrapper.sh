#!/bin/sh
# AWKesome copyright (c) 2016 Toru Niina
# desctiption
#   awk script wrapper
# How to use it
#   read help.

: "definition of include path" && {
    project_path="../"
    library_path=${project_path}"lib/"
    script_path=${project_path}"src/"
}

: "definition of each file include option" && {
    trigonometric_awk=${library_path}"Trigonometric.awk"       # asin, acos, atan
    vector_awk=${library_path}"VectorOperation.awk"
    matrix_awk=${library_path}"MatrixOperation.awk"
    jacobi_awk=${library_path}"JacobiMethod.awk"
    bestfit_awk=${library_path}"BestFit.awk"
    utility_awk=${library_path}"utils.awk"                     # abs
    pdb_reader_awk=${library_path}"PDBReader.awk"
}

help()
{
    echo "AWKesome version 1.0"
    echo 
    echo "this script is wrapper of AWKesome library."
    echo "this make it easier including files that you need."
    echo "use this way."
    echo "    $ sh wrapper.sh [library name] -f your_awesome_script.awk"
    echo 
    echo "and you can omit file/value definition option -f and -v."
    echo "so you can run your script more simply like this."
    echo "    $ sh wrapper.sh vector pdb your_awesome_script.awk value=1"
    echo 
    echo "this supports following library."
    echo "pdb     -- include PDBReader"
    echo "trigo   -- include Trigonometric"
    echo "vector  -- include VectorOperation (and dependency)"
    echo "matrix  -- include MatrixOperation (and dependency)"
    echo "jacobi  -- include JacobiMethod (and dependency)"
    echo "bestfit -- include BestFit (and dependency)"
    echo "util    -- include Utility funcs"
}

main()
{
    if [ "$#" -lt "2" ]; then
        help ;
        exit 1;
    fi

    if [ "$1" = "-h" -o "$1" = "--help" ]; then
        help ;
        exit 0;
    fi

    : "dependency flags" && {
        pdb_included=0;
        utility_included=0;
        trigo_included=0;
        vector_included=0;
        matrix_included=0;
        jacobi_included=0;
        bestfit_included=0;
    }

    : "format flag" && {
        value_flag=0
        file_flag=0
    }

    : "main program" && {
    cmd_str=" "
    for arg in $@ ; do
        case ${arg} in 
        "pdb")
            {
            if [ "${pdb_included}" -eq "0" ] ; then
                cmd_str=${cmd_str}" -f "${pdb_reader_awk}
                pdb_included=1
            fi
            }
        ;;
        "util")
            {
            if [ "${utility_included}" -eq "0" ] ; then
                cmd_str=${cmd_str}" -f "${utility_awk}
                utility_included=1
            fi
            }
        ;;
        "trigo")
            {
            if [ "${trigo_included}" -eq "0" ] ; then
                cmd_str=${cmd_str}" -f "${trigonometric_awk}
                trigo_included=1
            fi
            }
        ;;
        "vector")
            {
            if [ "${trigo_included}" -eq "0" ] ; then
                cmd_str=${cmd_str}" -f "${trigonometric_awk}
                trigo_included=1
            fi
            if [ "${vector_included}" -eq "0" ] ; then
                cmd_str=${cmd_str}" -f "${vector_awk}
                vector_included=1
            fi
            }
        ;;
        "matrix")
            {
            if [ "${trigo_included}" -eq "0" ] ; then
                cmd_str=${cmd_str}" -f "${trigonometric_awk}
                trigo_included=1
            fi
            if [ "${vector_included}" -eq "0" ] ; then
                cmd_str=${cmd_str}" -f "${vector_awk}
                vector_included=1
            fi
            if [ "${matrix_included}" -eq "0" ] ; then
                cmd_str=${cmd_str}" -f "${matrix_awk}
                matrix_included=1
            fi
            }
        ;;
        "jacobi")
            {
            if [ "${utility_included}" -eq "0" ] ; then
                cmd_str=${cmd_str}" -f "${utility_awk}
                utility_included=1
            fi
            if [ "${trigo_included}" -eq "0" ] ; then
                cmd_str=${cmd_str}" -f "${trigonometric_awk}
                trigo_included=1
            fi
            if [ "${vector_included}" -eq "0" ] ; then
                cmd_str=${cmd_str}" -f "${vector_awk}
                vector_included=1
            fi
            if [ "${matrix_included}" -eq "0" ] ; then
                cmd_str=${cmd_str}" -f "${matrix_awk}
                matrix_included=1
            fi
            if [ "${jacobi_included}" -eq "0" ] ; then
                cmd_str=${cmd_str}" -f "${jacobi_awk}
                jacobi_included=1
            fi
            }
        ;;
        "bestfit")
            {
            if [ "${utility_included}" -eq "0" ] ; then
                cmd_str=${cmd_str}" -f "${utility_awk}
                utility_included=1
            fi
            if [ "${trigo_included}" -eq "0" ] ; then
                cmd_str=${cmd_str}" -f "${trigonometric_awk}
                trigo_included=1
            fi
            if [ "${vector_included}" -eq "0" ] ; then
                cmd_str=${cmd_str}" -f "${vector_awk}
                vector_included=1
            fi
            if [ "${matrix_included}" -eq "0" ] ; then
                cmd_str=${cmd_str}" -f "${matrix_awk}
                matrix_included=1
            fi
            if [ "${jacobi_included}" -eq "0" ] ; then
                cmd_str=${cmd_str}" -f "${jacobi_awk}
                jacobi_included=1
            fi
            if [ "${bestfit_included}" -eq "0" ] ; then
                cmd_str=${cmd_str}" -f "${bestfit_awk}
                bestfit_included=1
            fi
            }
        ;;
        "-f")
            {
                file_flag=1
                cmd_str=${cmd_str}" "${arg}
            }
        ;;
        "-v")
            {
                value_flag=1
                cmd_str=${cmd_str}" "${arg}
            }
        ;;
        *awk) # user awk file
            {
                if [ ${file_flag} -eq "0" ] ; then
                    cmd_str=${cmd_str}" -f "${arg}
                else
                    cmd_str=${cmd_str}" "${arg}
                    file_flag=0
                fi
            }
        ;;
        *\=*) # user value definition
            {
                if [ ${value_flag} -eq "0" ] ; then
                    cmd_str=${cmd_str}" -v "${arg}
                else
                    cmd_str=${cmd_str}" "${arg}
                    value_flag=0
                fi
            }
        ;;
        *) # default
            {
                echo "unknown argument: "${arg}
                exit 1;
            }
        ;;
        esac
    done
    }
    echo "running \$awk "${cmd_str}"..." 1>&2
    awk ${cmd_str}
    echo "end." 1>&2
    exit 0;
}

main $@
