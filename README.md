AWKesome
====

AWKesome is AWESOME awk function library to analyze the output of cafemol.

## Functions

#### Trigonometric functions 
- tan(theta)
- acos(theta)
- asin(theta)
- atan(theta)
using awk's function atan2(x, y)

#### Vector Operation
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

##### PDB Reader
AWKesome store the pdb data as pseudo-multidimentional array.
To read some pdb file in your awk script, call PDBread() this way.

    PDBread("filename", DATA, SIZE)

here, DATA and SIZE is name of data array that you want to store the information.

You can access the information in pdb file like this way.

| key                 | value        | example |
|:--------------------|:-------------|:--------|
| DATA[M,N,"RESIDUE"] | residue name | "THR"   |
| DATA[M,N,"ATOM"]    | atom name    | "CA"    |
| DATA[M,N,"CHAIN"]   | chain name   | "A"     |
| DATA[M,N,"RESID"]   | residue id   | "THR"   |
| DATA[M,N,"X"]       | x coordinate | 1.0000  |
| DATA[M,N,"Y"]       | y coordinate | 1.0000  |
| DATA[M,N,"Z"]       | z coordinate | 1.0000  |

here, M means model index and N means particle index.

Of course, you can get the number of models in pdb file and
number of particles in one model with SIZE array.

| key              | value                            |
|:-----------------|:---------------------------------|
| SIZE["MODEL"]    | number of models in pdb file     |
| SIZE["PARTICLE"] | number of particles in one model |

## Sample Scripts

#### ContactMap
ContactMap.awk outputs the contact map of a certain model in pdb file.
    $ awk -f lib/PDBReader.awk -f lib/Trigonometric.awk -f lib/VectorOperation.awk -f src/ContactMap.awk -v threshold=6.5 -v pdbfile="hoge.pdb" -v model=1
Here, threshold is the definition of contact. If the distance of certain pair of
particle is lesser than this value, the particles are considered as making pair.
__pdbfile__ is the name of PDB file you want to analyze.
__model__ is an ID of the model you want to analize.

## Testing

    $ cd test/
    $ ./run_test

## Licensing Terms
This project is licensed under the terms of the MIT License.
See LICENSE for the project license.

- Copyright (c) 2016- Toru Niina

All rights reserved.
