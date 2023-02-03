# H5PART

H5PART is a structured HDF5 data format that stores multiple time-step data for particle simulation scenarios and can be used for ParaView / VisIt visualization.

**Suggestions and code contributions are welcome!**

## Dependencies

- HDF5 >= 1.10.6 .

## Build with [Fortran-lang/fpm][1]

````sh
fpm test # start unit tests
fpm run --example --all     # start examples
fpm build --profile release # build release version
````

[1]: https://github.com/fortran-lang/fpm

With fpm , the `h5part` package can be referenced directly.

````toml
[dependencies]
h5part = { git = "https://gitee.com/fortran-sph/h5part.git" }
````

## Link

- [h5part](https://dav.lbl.gov/archive/Research/AcceleratorSAPP/index.html)
- [pdlfs/h5part](https://github.com/pdlfs/h5part)
