!> Paraview example
program main

    use h5part_module
    implicit none

    integer(8) :: file_id, status, npoints, i
    real(8) :: origin, spacing
    real(8), allocatable :: x(:), y(:), z(:), px(:), py(:), pz(:)
    integer(8), allocatable :: id(:)

    npoints = 99_8

    allocate (x(npoints), y(npoints), z(npoints))
    allocate (px(npoints), py(npoints), pz(npoints))
    allocate (id(npoints))

    ! generate random data
    do i = 1, int(npoints)
        x(i) = -50.0_8 + randn()
        y(i) = -50.1_8 + randn()
        z(i) = -50.2_8 + randn()
        px(i) = 0.3 + real(i)
        py(i) = 0.4 + randn()
        pz(i) = 0.5 + 10*randn()
        id(i) = i
    end do

    ! open file for writing
    file_id = h5pt_openw("./example/pv.h5part")
    if (file_id == 0) error stop 'h5part is occupied ?!'

    ! set file step
    status = h5pt_setstep(file_id, step=1_8)

    status = h5pt_writefileattrib_string(file_id, "author", "foobar")
    status = h5pt_writefileattrib_string(file_id, "date", "2022-06-27")

    status = h5pt_setnpoints(file_id, npoints=npoints)

    ! x, y, z must be written to file, which is the coordinate of particles
    status = h5pt_writedata(file_id, "x", x)
    status = h5pt_writedata(file_id, "y", y)
    status = h5pt_writedata(file_id, "z", z)
    ! px, py, pz are the properties of particles
    status = h5pt_writedata(file_id, "px", px)
    status = h5pt_writedata(file_id, "py", py)
    status = h5pt_writedata(file_id, "pz", pz)
    status = h5pt_writedata(file_id, "id", id)

    ! close file
    status = h5pt_close(file_id)

contains

    real(8) function randn()

        call random_number(randn)

    end function randn

end program main
