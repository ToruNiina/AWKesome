AWKesome
====

AWKesome is an AWESOME awk library to analyze output datas of the cafemol.

This also provide wrapper of awk that makes running awk script dramatically easy.

## Install

At first, set the path using CMake.

```sh
$ cd build
$ cmake ..
```

After that, add /path/to/awkesome/ to your command pathes.
Then you can run awkesome as

```sh
$ awkesome
```

## Usage
You can run your awk script in this way.

```sh
$ awkesome your_awesome_script.awk foo="foo" bar="bar"
```

You are now free from writing `-f` or `-v` options.
Additionally, you can load `AWKesome` library like this.

```sh
$ awkesome pdb matrix your_awesome_script.awk foo="foo" bar="bar"
```

Yes, you can call `PDBReader` as `pdb`. And you can call `MatrixOperation.awk`
as `matrix`.
It also manages the dependency of library files, so you don't have to mind
the order of loading library files at all.

For more information, run

```sh
$ awkesome --help
```

## sample scripts

there are two sample scripts in awksome repository.

### ContactMap
ContactMap.awk outputs the contact map of a certain model in pdb file.

```sh
$awkesome pdb vector src/ContactMap.awk threshold=6.5 pdbfile="hoge.pdb" model=1
```

Here, `threshold` is the threshold of distance that define
whether a contact exists for a certain pair.
If a distance between a certain pair of particles is lesser than this value,
the particles are considered as making contact.
`pdbfile` is a name of PDB file you want to read.
`model` is an ID of the model you want to read.

### RMSDCalculator

RMSDCalculator.awk calculates RMSD between a reference structure and trajectory.

```sh
$awkesome pdb bestfit src/RMSDCalculator.awk ref=reference.pdb movie=some.movie
```

As reference structure, PDB file that contains CG-structure of the model is required.
And the reference PDB must not contain MODEL line.

There are sample data that can be used for RMSDCalculation in `data` directory.

To try RMSDCalculator, do following way on top directory of this project.

```sh
$awkesome pdb bestfit ./src/RMSDCalculator.awk "./data/sh3_native.pdb" \
          movie="./data/sh3_native.movie" > sh3_rmsd.dat
```

If you want to test, compare a result to a CafeMol's `ts` file.

Because `ts` file rounds the values and `RMSDCalculater` do not,
you find the difference between them at a quick glance.

__NOTE__: This calculation will be performed for whole structure. Not each chain.

## For Developpers

AWKesome provides useful awk functions listed below.

### Trigonometric functions
- tan(theta)
- acos(theta)
- asin(theta)
- atan(theta)

### Utility functions
- abs(x)

### Vector Operation
AWKesome represents 3 dimensional vector as an array of numbers.
You can access a value in the vector with index 0,1,2.

| name of function           | description                      |
|:---------------------------|:---------------------------------|
| `vec_len\_sq(vec)`         | return squared length            |
| `vec_len(vec)`             | return length                    |
| `vec_add(lhs, rhs, ret)`   | ret = lhs + rhs                  |
| `vec_sub(lhs, rhs, ret)`   | ret = lhs - rhs                  |
| `vec_mul(vec, scl, ret)`   | ret = vector * scalar            |
| `vec_div(vec, scl, ret)`   | ret = vector / scalar            |
| `vec_dot(lhs, rhs)`        | return dot product               |
| `vec_cross(lhs, rhs, ret)` | return cross product             |
| `vec_angle(lhs, rhs)`      | return angle between lhs and rhs |
| `vec_print(vec)`           | prints the vector                |

### PDB Reader

AWKesome stores a pdb data as a multidimentional array.
To read a pdb file in your awk script, call PDBread() like this.

```awk
PDBread("filename", DATA, SIZE)
```

Here, `DATA` is a name of data that you want to store the structural information.
`SIZE` will be filled by the size of each array.
You can get the number of models and particles in a PDB file from `SIZE`.

| key                   | value        | example |
|:----------------------|:-------------|:--------|
| `DATA[M,N,"RESIDUE"]` | residue name | "THR"   |
| `DATA[M,N,"ATOM"]`    | atom name    | "CA"    |
| `DATA[M,N,"CHAIN"]`   | chain name   | "A"     |
| `DATA[M,N,"RESID"]`   | residue id   | 12      |
| `DATA[M,N,"X"]`       | x coordinate | 1.0000  |
| `DATA[M,N,"Y"]`       | y coordinate | 1.0000  |
| `DATA[M,N,"Z"]`       | z coordinate | 1.0000  |

here, `M` means model index and `N` means particle index.

| key                | value                              |
|:-------------------|:-----------------------------------|
| `SIZE["MODEL"]`    | a number of models in pdb file     |
| `SIZE["PARTICLE"]` | a number of particles in one model |

__NOTE__: If you read a pdb file that have no MODEL line, `PDBReader` stores the
structural data at `DATA[0,N,"foo"]` and `SIZE["MODEL"]` become zero.

### Matrix Operation
AWKesome represents Matrix as a multidimentional array of numbers.
The same kind of functions as vector operation are supported.

See `lib/MatrixOperation.awk`.

### Jacobi Method
Calculate eigenvectors and eigenvalues of a symmetric matrix.

See `lib/JacobiMethod.awk`.

### BestFit
Calculate the best fit rotation matrix and return rotated structure.

See `lib/BestFit.awk`.

## Testing

`AWKesome` has some testing scripts. You can test the code.

    $ cd test/
    $ ./run_test

## Licensing Terms
This project is licensed under the terms of the MIT License.
See LICENSE for the project license.

- Copyright (c) 2016 Toru Niina

All rights reserved.
