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

## Testing

    cd test/
    ./run_test

## Licensing Terms
This project is licensed under the terms of the MIT License.
See LICENSE for the project license.

- Copyright (c) 2016- Toru Niina

All rights reserved.
