module test_h5part_module

    use testdrive, only: new_unittest, unittest_type, error_type, check
    use h5part_module
    implicit none

    private
    public :: collect_h5part

    character(*), parameter :: test_h5part_file = "test/test.h5part"

contains

    !> Collect all exported unit tests
    subroutine collect_h5part(testsuite)
        !> Collection of tests
        type(unittest_type), allocatable, intent(out) :: testsuite(:)

        allocate (testsuite, source=[ &
                  new_unittest("h5pt_writedata", test_h5pt_writedata), &
                  new_unittest("h5pt_readdata", test_h5pt_readdata) &
                  ! new_unittest("FUNCTION: h5pt_writefileattrib", test_h5pt_writefileattrib), &
                  ! new_unittest("FUNCTION: h5pt_readfileatrib", test_h5pt_readfileatrib), &
                  ! new_unittest("FUNCTION: h5pt_writestepattrib", test_h5pt_writestepattrib), &
                  ! new_unittest("FUNCTION: h5pt_readstepattrib", test_h5pt_readstepattrib) &
                  ])

    end subroutine collect_h5part

    subroutine test_h5pt_writedata(error)
        type(error_type), allocatable, intent(out) :: error
        integer(8) :: fid, status

        fid = h5pt_openw(test_h5part_file)
        status = h5pt_setstep(fid, 1_8)
        status = h5pt_setnpoints(fid, 3_8)

        status = h5pt_writedata(fid, "x", [1.0_8, 2.0_8, 3.0_8])
        call check(error, int(status, 4), "h5pt_writedata: x")

        status = h5pt_writedata(fid, "y", [4.0, 5.0, 6.0])
        call check(error, int(status, 4), "h5pt_writedata: y")

        status = h5pt_close(fid)

    end subroutine test_h5pt_writedata

    subroutine test_h5pt_readdata(error)
        type(error_type), allocatable, intent(out) :: error
        integer(8) :: fid, status
        real(8) :: x(3)
        real :: y(3)

        fid = h5pt_openr(test_h5part_file)
        status = h5pt_setstep(fid, 1_8)
        status = h5pt_setnpoints(fid, 3_8)

        status = h5pt_readdata(fid, "x", x)
        call check(error, int(status, 4), "h5pt_readdata: x")
        if (allocated(error)) return

        call check(error, all(abs(x - [1.0_8, 2.0_8, 3.0_8]) < 1.0e-4_8), "h5pt_readdata: x values")
        if (allocated(error)) return

        status = h5pt_readdata(fid, "y", y)
        call check(error, int(status, 4), "h5pt_readdata: y")
        if (allocated(error)) return

        call check(error, all(abs(y - [4.0, 5.0, 6.0]) < 1.0e-4), "h5pt_readdata: y values")

        status = h5pt_close(fid)

    end subroutine test_h5pt_readdata

end module test_h5part_module
