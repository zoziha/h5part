!> View test.h5: `h5dump test.h5`
!> 查看test.h5文件的内容：`h5dump test.h5`
program H5PartTest

    implicit none
    interface
        include "../inc/H5Part.f90"
        include "../inc/H5PartAttrib.f90"
    end interface

#ifdef PARALLEL_IO
    include 'mpif.h'
#endif

#ifdef PARALLEL_IO
    integer :: comm, ierr
#endif
    INTEGER(8) :: file_id, status, npoints, i
    REAL(8), allocatable :: x(:), y(:), z(:), px(:), py(:), pz(:)
    INTEGER(8), allocatable :: id(:)

#ifdef PARALLEL_IO
    call MPI_INIT(ierr)
    comm = MPI_COMM_WORLD
#endif

    ! this enables level 4 ("debug") messages to be
    ! printed by the H5Part library
    ! (4_8 is the literal for an INTEGER(8) with value 4)
    status = h5pt_set_verbosity_level(4_8)

    ! open the a file called 'test.h5' in parallel for writing
#ifdef PARALLEL_IO
    file_id = h5pt_openw_par('./example/testf.h5part', comm)
#else
    file_id = h5pt_openw('./example/testf.h5part')
#endif

    ! in the Fortran API, steps start at 1
    status = h5pt_setstep(file_id, 1_8)

    ! write an attribute to the file
    status = h5pt_writefileattrib_string(file_id, 'author', 'foo')
    status = h5pt_writefileattrib_string(file_id, 'desc', 'This is a test.')

    ! set the size of the data array
    npoints = 99
    status = h5pt_setnpoints(file_id, npoints)

    ! create fake data
    allocate (x(npoints), y(npoints), z(npoints))
    allocate (px(npoints), py(npoints), pz(npoints))
    allocate (id(npoints))
    do i = 1, int(npoints)
        x(i) = 0.0 + real(i)
        y(i) = 0.1 + real(i)
        z(i) = 0.2 + real(i)
        px(i) = 0.3 + real(i)
        py(i) = 0.4 + real(i)
        pz(i) = 0.5 + real(i)
        id(i) = i
    end do

    ! write the data
    status = h5pt_writedata_r8(file_id, "x", x)
    status = h5pt_writedata_r8(file_id, "y", y)
    status = h5pt_writedata_r8(file_id, "z", z)
    status = h5pt_writedata_r8(file_id, "px", px)
    status = h5pt_writedata_r8(file_id, "py", py)
    status = h5pt_writedata_r8(file_id, "pz", pz)
    status = h5pt_writedata_i8(file_id, "id", id)

    ! close the file
    status = h5pt_close(file_id)

#ifdef PARALLEL_IO
    call MPI_FINALIZE(ierr)
#endif

end program H5PartTest

