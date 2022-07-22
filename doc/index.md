title: 规范与帮助
---

H5PART 是一种具体结构的 HDF5 数据格式，它针对粒子模拟场景的多个时间步数据存储，可用于 ParaView / VisIt 可视化。

H5Part 基于 HDF5-C-API 形成面向粒子模拟的高效数据结构，并且提供了 Fortran 接口；
实践表明，如果使用 [H5Fortran][1] 库来实现相同的数据格式，效率将降低约 3 倍。

[1]: https://github.com/geospace-code/h5fortran
