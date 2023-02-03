title: paraview
---

## ParaView 教程

ParaView 中的 H5Part 插件，仅访问 H5part 库中的 H5part 部分，未涉及 h5ptock 部分。
ParaView 默认读取 H5part 文件中的 `x`, `y`, `z` 字段，并将其作为粒子的坐标，用户可自行添加其他 part 字段，作为粒子的属性。
由于 h5ptock 部分的数据被 ParaView 忽略了，存储在 Block 中的数据不会被读取显示，仅可作为用户自定义数据存储空间。

```sh
--- /
    |-- /Step#0
            |-- /Block
                  |-- ...
            |-- /x
            |-- /y
            |-- /z
            |-- ...
    |-- /Step#1
    ...
```