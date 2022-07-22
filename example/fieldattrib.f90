!> 为场施加属性
program main

    use h5part_m
    implicit none

    integer*8 :: file_id, status, npoints, i
    real*8 :: origin, spacing
    real*8, allocatable :: x(:), y(:), z(:)
    integer*8, allocatable :: id(:)

    file_id = h5pt_openw("./example/field.h5part")
    status = h5pt_setstep(file_id, 1_8)

    status = h5pt_writefileattrib_string(file_id, "author", "foo")
    status = h5pt_writefileattrib_string(file_id, "date", "2022-06-27")

    npoints = 3
    status = h5pt_setnpoints(file_id, npoints)

    allocate (x(npoints), y(npoints), z(npoints))
    allocate (id(npoints))

    do i = 1, int(npoints)
        x(i) = -50.0 + real(i)
        y(i) = -50.1 + real(i)
        z(i) = -50.2 + real(i)
        id(i) = i
    end do

    status = h5bl_define3dchunkdims(file_id, 3_8, 1_8, 1_8)
    status = h5bl_define3dlayout(file_id, 1_8, 3_8, 1_8, 1_8, 1_8, 1_8)
    status = h5pt_writedata_i8(file_id, "id", id)
    
    print *, h5bl_has_fielddata(file_id)
    status = h5bl_3d_write_3dvector_field_r8(file_id, "loc", x, y, z)
    status = h5bl_writefieldattrib_string(file_id, "loc", "desc", "location")
    print *, h5bl_has_fielddata(file_id)
    
    
    status = h5bl_3d_write_scalar_field_r8(file_id, "x", x)
    origin = 0.0
    spacing = 1.0
    status = h5bl_3d_set_field_origin(file_id, "x", origin, origin, origin)
    status = h5bl_3d_set_field_spacing(file_id, "x", spacing, spacing, spacing)

    status = h5pt_close(file_id)

end program main
