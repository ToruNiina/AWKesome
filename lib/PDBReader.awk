#!/usr/bin/awk -f
# AWKesome Copyright (c) 2016 Toru Niina
# desctiption
#   PDBreader reads pdb file. If you call PDBread(filename, DATA, SIZE), 
#   DATA become a multi array. You can access the value like this.
#   M means model ID, N means Particle ID.
#       DATA[M, N, "RESIDUE"] = "ALA"
#       DATA[M, N, "ATOM"]    = "CA"
#       DATA[M, N, "CHAIN"]   = "A"
#       DATA[M, N, "RESID"]   = 10
#       DATA[M, N, "X"]       = x coordinate
#       DATA[M, N, "Y"]       = y coordinate
#       DATA[M, N, "Z"]       = z coordinate
#   SIZE also become a multi array. This contains the number of models and
#   the number of particles in one model. 
#       SIZE["MODEL"]    = number of models in the file
#       SIZE["PARTICLE"] = number of particles in one model
# How to use it
#   run following way.
#   $ awk -f PDBReader.awk -f your_awesome_awk_script.awk

function read_pdb_line(model, imp, data_array) {
    data_array[model, imp, "RESIDUE"] = $3
    data_array[model, imp, "ATOM"] = $4
    data_array[model, imp, "CHAIN"] = $5
    data_array[model, imp, "RESID"] = $6
    data_array[model, imp, "X"] = $7
    data_array[model, imp, "Y"] = $8
    data_array[model, imp, "Z"] = $9
    return
}

function PDBread(pdb_filename, data_array_name, size_value) {
    model_id = 0
    particle_id = 1

    CAT_FILE = "cat " pdb_filename;
    while ((CAT_FILE | getline) > 0) {
        if($1 == "MODEL") {
            model_id++
            particle_id = 1
            continue
        }
        if($1=="ATOM") {
            read_pdb_line(model_id, particle_id, data_array_name)
            particle_id++
        }
    }
    close(CAT_FILE);
    size_value["MODEL"] = model_id
    size_value["PARTICLE"] = particle_id
}
