!> author: 左志华
!> date: 2022-07-12
!>
!> H5PART for Fortran
!> H5PART Fortran 接口
module h5part_m

    implicit none

    !> Write dataset to timestep
    !> 写入数据集到时间步
    interface h5pt_writedata
        procedure :: h5pt_writedata_i4
        procedure :: h5pt_writedata_i8
        procedure :: h5pt_writedata_r4
        procedure :: h5pt_writedata_r8
    end interface

    !> Read dataset from timestep
    !> 读取数据集从时间步
    interface h5pt_readdata
        procedure :: h5pt_readdata_i4
        procedure :: h5pt_readdata_i8
        procedure :: h5pt_readdata_r4
        procedure :: h5pt_readdata_r8
    end interface

    !> Write attribute to H5part file
    !> 写入属性到H5part文件
    interface h5pt_writefileattrib
        procedure :: h5pt_writefileattrib_string
        procedure :: h5pt_writefileattrib_i4
        procedure :: h5pt_writefileattrib_i8
        procedure :: h5pt_writefileattrib_r4
        procedure :: h5pt_writefileattrib_r8
    end interface

    !> Read attribute from H5part file
    !> 读取属性从H5part文件
    interface h5pt_readfileattrib
        procedure :: h5pt_readfileattrib_string
        procedure :: h5pt_readfileattrib_i4
        procedure :: h5pt_readfileattrib_i8
        procedure :: h5pt_readfileattrib_r4
        procedure :: h5pt_readfileattrib_r8
    end interface

    !> Write an attribute to timestep
    !> 写入属性到时间步
    interface h5pt_writestepattrib
        procedure :: h5pt_writestepattrib_string
        procedure :: h5pt_writestepattrib_i4
        procedure :: h5pt_writestepattrib_i8
        procedure :: h5pt_writestepattrib_r4
        procedure :: h5pt_writestepattrib_r8
    end interface

    !> Read attribute from timestep
    !> 读取属性从时间步
    interface h5pt_readstepattrib
        procedure :: h5pt_readstepattrib_string
        procedure :: h5pt_readstepattrib_i4
        procedure :: h5pt_readstepattrib_i8
        procedure :: h5pt_readstepattrib_r4
        procedure :: h5pt_readstepattrib_r8
    end interface

    interface
        include "../h5part/inc/H5Part.f90"
        include "../h5part/inc/H5PartAttrib.f90"
    end interface

end module h5part_m
