# H5PART

H5PART 是一种具体结构的 HDF5 数据格式，它针对粒子模拟场景的多个时间步数据存储，可用于 ParaView / VisIt 可视化。

**欢迎建议与代码贡献！**

## 依赖

- HDF5 >= 1.10.6 .

## 使用 [Fortran-lang/fpm][1] 构建

```sh
fpm test    # 启动单元测试
fpm run --example --all     # 启动示例
fpm build --profile release # 构建 release 版本
```

[1]: https://github.com/fortran-lang/fpm

通过 fpm ，可以直接引用 h5part 包。

```toml
[dependencies]
h5part = { git = "https://gitee.com/fortran-sph/h5part.git" }
```

## 链接

- [h5part](https://dav.lbl.gov/archive/Research/AcceleratorSAPP/index.html)
