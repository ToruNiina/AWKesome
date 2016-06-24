AWKesome
====

AWKesome is AWESOME awk function library to analyze the output of cafemol.

This also provide awk wrapper that makes running awk script dramatically easyer.

## Install

add awkesome/src/ to your command path. you will be able to call
awkesome::wrapper as

    $ awkesome 

## Functions

### Trigonometric functions
- tan(theta)
- acos(theta)
- asin(theta)
- atan(theta)
using awk's function atan2(x, y)

### Utility functions
- abs(x)

### Vector Operation
AWKesome represents Vector3d as array of numbers. The values must be accessible
with index 0,1,2.

| name of function          | description                       |
|:--------------------------|:----------------------------------|
| vec\_len\_sq(vec)         | returns squared length            |
| vec\_len(vec)             | returns length                    |
| vec\_add(lhs, rhs, ret)   | ret = lhs + rhs                   |
| vec\_sub(lhs, rhs, ret)   | ret = lhs - rhs                   |
| vec\_mul(vec, scl, ret)   | ret = vec * scl                   |
| vec\_div(vec, scl, ret)   | ret = vec / scl                   |
| vec\_dot(lhs, rhs)        | returns dot product               |
| vec\_cross(lhs, rhs, ret) | returns cross product             |
| vec\_angle(lhs, rhs)      | returns angle between lhs and rhs |
| vec\_print(vec)           | prints the vector                 |

### PDB Reader
AWKesome store the pdb data as pseudo-multidimentional array.
To read some pdb file in your awk script, call PDBread() this way.

    PDBread("filename", DATA, SIZE)

here, _DATA_ and _SIZE_ is name of data array that you want to store the information.

You can access the information in pdb file like this way.

| key                 | value        | example |
|:--------------------|:-------------|:--------|
| DATA[M,N,"RESIDUE"] | residue name | "THR"   |
| DATA[M,N,"ATOM"]    | atom name    | "CA"    |
| DATA[M,N,"CHAIN"]   | chain name   | "A"     |
| DATA[M,N,"RESID"]   | residue id   | 12      |
| DATA[M,N,"X"]       | x coordinate | 1.0000  |
| DATA[M,N,"Y"]       | y coordinate | 1.0000  |
| DATA[M,N,"Z"]       | z coordinate | 1.0000  |

here, _M_ means model index and _N_ means particle index.

Of course, you can get the number of models in pdb file and
number of particles in one model with SIZE array.

| key              | value                            |
|:-----------------|:---------------------------------|
| SIZE["MODEL"]    | number of models in pdb file     |
| SIZE["PARTICLE"] | number of particles in one model |

__NOTE__: If you read a pdbfile that have no MODEL line, PDBReader stores the
model in DATA[0,N,"foo"] and SIZE["MODEL"] become zero. Please be careful.

### Matrix Operation
AWKesome represents Matrix as pseudo-multidimentional array of numbers.
About the same kind of functions as vector operation are supported.
See lib/MatrixOperation.awk.

### Jacobi Method
Calculate the eigenvectors and eigenvalues of symmetric matrix.
See lib/JacobiMethod.awk.

### BestFit
Calculate the best fit rotation and return the rotated structure.
See lib/BestFit.awk.

## Sample Scripts

### Wrapper
AWKesome provides awk wrapper that makes running your awk script dramatically
easier. You can run your script like this.

    $ awkesome your_awesome_script.awk foo="foo" bar="bar"

You are now released from writing "-f" or "-v" options. And ofcourse, you can 
call AWKesome library files more easier like this.

    $ awkesome pdb matrix your_awesome_script.awk foo="foo" bar="bar"

Yes, you can call PDBReader as "pdb". And you can call
"-f path/to/lib/MatrixOperation.awk" as "matrix". wrapper also manages the
dependency of library files, so you don't have to mind the dependency at all.
You can successfully call the library if you do this.

    $ awkesome pdb pdb pdb pdb pdb your_awesome_script.awk

For more information, run

    $ awkesome --help

### ContactMap
ContactMap.awk outputs the contact map of a certain model in pdb file.

    $awk -f lib/PDBReader.awk -f lib/Trigonometric.awk -f lib/VectorOperation.awk \
         -f src/ContactMap.awk -v threshold=6.5 -v pdbfile="hoge.pdb" -v model=1

or with AWKesome::wrapper,

    $awkesome pdb vector src/ContactMap.awk threshold=6.5 pdbfile="hoge.pdb" model=1

Here, _threshold_ is the definition of contact. If the distance of certain pair
of particle is lesser than this value, the particles are considered as making
pair.
_pdbfile_ is the name of PDB file you want to analyze.
_model_ is an ID of the model you want to analize.

### RMSDCalculator
RMSDCalculator.awk calculates RMSD.

    $awk -f lib/PDBReader.awk -f lib/Trigonometric.awk -f lib/VectorOperation.awk \
         -f lib/utils.awk -f MatrixOperation.awk -f lib/JacobiMethod.awk \
         -f lib/BestFit.awk src/RMSDCalculator.awk -v ref=reference.pdb \
         -v movie=some.movie

or with AWKesome::wrapper,

    $awkesome pdb bestfit src/RMSDCalculator.awk ref=reference.pdb movie=some.movie


As reference structure, PDB file that contains CG-structure of the model is
required.
The reference PDB must not contain MODEL line.

In data/ directory, sample data that can be used for RMSDCalculation exist.
To try RMSDCalculator, do following way on top directory of this project.

    $awk -f lib/PDBReader.awk -f lib/Trigonometric.awk -f lib/VectorOperation.awk \
         -f lib/utils.awk -f MatrixOperation.awk -f lib/JacobiMethod.awk \
         -f lib/BestFit.awk src/RMSDCalculator.awk -v ref="./data/sh3_native.pdb" \
         -v movie="./data/sh3_native.movie" > sh3_rmsd.dat

or with AWKesome::wrapper,

    $./src/awkesome pdb bestfit ./src/RMSDCalculator.awk "./data/sh3_native.pdb" \
         movie="./data/sh3_native.movie" > sh3_rmsd.dat

And compare CafeMol's ts file.
Because ts file rounds the values, you find the difference between them at
a quick glance, but these are almost same if my scripts runs correctly on
your environment.

__NOTE__: This calculates only whole structure. Not each chain.

## Testing

    $ cd test/
    $ ./run_test

## Licensing Terms
This project is licensed under the terms of the MIT License.
See LICENSE for the project license.

- Copyright (c) 2016 Toru Niina

All rights reserved.
