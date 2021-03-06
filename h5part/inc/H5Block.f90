! Declaration of subroutines for Fortran Bindings

!> \defgroup h5block_f90_api H5Block F90 API

!> \ingroup h5block_f90_api
!! \defgroup h5blockf_model      Setting up the Data Model
!<

!> \ingroup h5block_f90_api
!! \defgroup h5blockf_data       Reading and Writing Datasets
!<

!> \ingroup h5block_f90_api
!! \defgroup h5blockf_attrib     Reading and Writing Attributes
!<

!!!!!!!! Setting up the Data Model !!!!!!!!

!> \ingroup h5blockf_model
!! See \ref H5BlockDefine3DFieldLayout
!! \return 0 on success or error code
!<
INTEGER*8 FUNCTION h5bl_define3dlayout(filehandle, i_start, i_end, j_start, j_end, k_start, k_end)
    INTEGER*8, INTENT(IN) :: filehandle
    INTEGER*8, INTENT(IN) :: i_start
    INTEGER*8, INTENT(IN) :: i_end
    INTEGER*8, INTENT(IN) :: j_start
    INTEGER*8, INTENT(IN) :: j_end
    INTEGER*8, INTENT(IN) :: k_start
    INTEGER*8, INTENT(IN) :: k_end
END FUNCTION

!> \ingroup h5blockf_model
!! See \ref H5BlockDefine3DChunkDims
!! \return 0 on success or error code
!<
INTEGER*8 FUNCTION h5bl_define3dchunkdims(filehandle, i, j, k)
    INTEGER*8, INTENT(IN) :: filehandle
    INTEGER*8, INTENT(IN) :: i
    INTEGER*8, INTENT(IN) :: j
    INTEGER*8, INTENT(IN) :: k
END FUNCTION

!> \ingroup h5blockf_model
!! See \ref H5Block3dGetPartitionOfProc
!! \return 0 on success or error code
!<
INTEGER*8 FUNCTION h5bl_get_partition_of_proc(filehandle, proc, i_start, i_end, j_start, j_end, k_start, k_end)
    INTEGER*8, INTENT(IN) :: filehandle
    INTEGER*8, INTENT(OUT) :: proc
    INTEGER*8, INTENT(OUT) :: i_start
    INTEGER*8, INTENT(OUT) :: i_end
    INTEGER*8, INTENT(OUT) :: j_start
    INTEGER*8, INTENT(OUT) :: j_end
    INTEGER*8, INTENT(OUT) :: k_start
    INTEGER*8, INTENT(OUT) :: k_end
END FUNCTION

!> \ingroup h5blockf_model
!! See \ref H5Block3dGetReducedPartitionOfProc
!! \return 0 on success or error code
!<
INTEGER*8 FUNCTION h5bl_get_reduced_partition_of_proc(filehandle, proc, i_start, i_end, j_start, &
                                                      j_end, k_start, k_end)
    INTEGER*8, INTENT(IN) :: filehandle
    INTEGER*8, INTENT(OUT) :: proc
    INTEGER*8, INTENT(OUT) :: i_start
    INTEGER*8, INTENT(OUT) :: i_end
    INTEGER*8, INTENT(OUT) :: j_start
    INTEGER*8, INTENT(OUT) :: j_end
    INTEGER*8, INTENT(OUT) :: k_start
    INTEGER*8, INTENT(OUT) :: k_end
END FUNCTION

!> \ingroup h5blockf_model
!! See \ref H5Block3dGetProcOf
!! \return rank of processor error code
!<
INTEGER*8 FUNCTION h5bl_get_proc_of(filehandle, i, j, k)
    INTEGER*8, INTENT(IN) :: filehandle
    INTEGER*8, INTENT(IN) :: i
    INTEGER*8, INTENT(IN) :: j
    INTEGER*8, INTENT(IN) :: k
END FUNCTION

!> \ingroup h5blockf_model
!! See \ref H5BlockGetNumFields
!! \return number of fields or error code
!<
INTEGER*8 FUNCTION h5bl_getnumfields(filehandle)
    INTEGER*8, INTENT(IN) :: filehandle
END FUNCTION

!> \ingroup h5blockf_model
!! See \ref H5BlockGetFieldInfo
!! \return 0 on success or error code
!<
INTEGER*8 FUNCTION h5bl_getfieldinfo(filehandle, idx, field_name, grid_rank, grid_dims, field_dims, type)
    INTEGER*8, INTENT(IN) :: filehandle
    INTEGER*8, INTENT(IN) :: idx
    CHARACTER(LEN=*), INTENT(OUT) :: field_name
    INTEGER*8, INTENT(OUT) :: grid_rank
    INTEGER*8, INTENT(OUT) :: grid_dims(*)
    INTEGER*8, INTENT(OUT) :: field_dims
    INTEGER*8, INTENT(OUT) :: type
END FUNCTION

!> \ingroup h5blockf_model
!! See \ref H5BlockHasFieldData
!! \return 0 if false, 1 if true, or error code
!<
INTEGER*8 FUNCTION h5bl_has_fielddata(filehandle)
    INTEGER*8, INTENT(IN) :: filehandle
END FUNCTION

!!!!!!!! Reading and Writing Attributes !!!!!!!!

!> \ingroup h5blockf_attrib
!! See \ref H5BlockWriteFieldAttribString
!! \return 0 on success or error code
!<
INTEGER*8 FUNCTION h5bl_writefieldattrib_string(filehandle, field_name, attrib_name, attrib_value)
    INTEGER*8, INTENT(IN) :: filehandle
    CHARACTER(LEN=*), INTENT(IN) :: field_name    ! The name of the field
    CHARACTER(LEN=*), INTENT(IN) :: attrib_name   ! The name of the attribute
    CHARACTER(LEN=*), INTENT(IN) :: attrib_value  ! The array of data to write into the attribute
END FUNCTION

!> \ingroup h5blockf_attrib
!! See \ref H5BlockGetNumFieldAttribs
!! \return number of attributes or error code
!<
INTEGER*8 FUNCTION h5bl_getnfieldattribs(filehandle, field_name)
    INTEGER*8, INTENT(IN) :: filehandle
    CHARACTER(LEN=*), INTENT(IN) :: field_name    ! The name of the field
END FUNCTION

!> \ingroup h5blockf_attrib
!! See \ref H5BlockGetFieldAttribInfo
!! \return 0 on success or error code
!<
INTEGER*8 FUNCTION h5bl_getfieldattribinfo(filehandle, field_name, idx, attrib_name, attrib_nelem)
    INTEGER*8, INTENT(IN) :: filehandle
    CHARACTER(LEN=*), INTENT(IN) :: field_name   ! The name of the field
    INTEGER*8, INTENT(IN) :: idx  ! index of the attribute being queried
    CHARACTER(LEN=*), INTENT(OUT) :: attrib_name  ! The name of the attribute
    INTEGER*8, INTENT(OUT) :: attrib_nelem ! Number of elements in the attrib array
END FUNCTION

!> \ingroup h5blockf_attrib
!! Read the attribute \c attrib_name from the field \c field_name at the
!! current timestep, and store the int64 value in \c attrib_value.
!! \return 0 on success or error code
!<
INTEGER*8 FUNCTION h5bl_readfieldattrib_i8(filehandle, field_name, attrib_name, attrib_value)
    INTEGER*8, INTENT(IN) :: filehandle
    CHARACTER(LEN=*), INTENT(IN) :: field_name    ! The name of the field
    CHARACTER(LEN=*), INTENT(IN) :: attrib_name   ! name of the attribute to read
    INTEGER*8, INTENT(OUT) :: attrib_value(*)! the attribute data will be read into this array
END FUNCTION

!> \ingroup h5blockf_attrib
!! Read the attribute \c attrib_name from the field \c field_name at the
!! current timestep, and store the float64 value in \c attrib_value.
!! \return 0 on success or error code
!<
INTEGER*8 FUNCTION h5bl_readfieldattrib_r8(filehandle, field_name, attrib_name, attrib_value)
    INTEGER*8, INTENT(IN) :: filehandle
    CHARACTER(LEN=*), INTENT(IN) :: field_name    ! The name of the field
    CHARACTER(LEN=*), INTENT(IN) :: attrib_name   ! name of the attribute to read
    REAL*8, INTENT(OUT) :: attrib_value(*)! the attribute data will be read into this array
END FUNCTION

!> \ingroup h5blockf_attrib
!! Read the attribute \c attrib_name from the field \c field_name at the
!! current timestep, and store the string value in \c attrib_value.
!! \return 0 on success or error code
!<
INTEGER*8 FUNCTION h5bl_readfieldattrib_string(filehandle, field_name, attrib_name, attrib_value)
    INTEGER*8, INTENT(IN) :: filehandle
    CHARACTER(LEN=*), INTENT(IN) :: field_name    ! The name of the field
    CHARACTER(LEN=*), INTENT(IN) :: attrib_name   ! name of the attribute to read
    CHARACTER(LEN=*), INTENT(IN) :: attrib_value  ! The array of data to write into the attribute
END FUNCTION

!> \ingroup h5blockf_attrib
!! See \ref H5Block3dGetFieldSpacing
!! \return 0 on success or error code
!<
INTEGER*8 FUNCTION h5bl_3d_get_field_spacing(filehandle, name, x, y, z)
    INTEGER*8, INTENT(IN) :: filehandle
    CHARACTER(LEN=*), INTENT(IN) :: name
    REAL*8, INTENT(OUT) :: x
    REAL*8, INTENT(OUT) :: y
    REAL*8, INTENT(OUT) :: z
END FUNCTION

!> \ingroup h5blockf_attrib
!! See \ref H5Block3dSetFieldSpacing
!! \return 0 on success or error code
!<
INTEGER*8 FUNCTION h5bl_3d_set_field_spacing(filehandle, name, x, y, z)
    INTEGER*8, INTENT(IN) :: filehandle
    CHARACTER(LEN=*), INTENT(IN) :: name
    REAL*8, INTENT(IN) :: x
    REAL*8, INTENT(IN) :: y
    REAL*8, INTENT(IN) :: z
END FUNCTION

!> \ingroup h5blockf_attrib
!! See \ref H5Block3dGetFieldOrigin
!! \return 0 on success or error code
!<
INTEGER*8 FUNCTION h5bl_3d_get_field_origin(filehandle, name, x, y, z)
    INTEGER*8, INTENT(IN) :: filehandle
    CHARACTER(LEN=*), INTENT(IN) :: name
    REAL*8, INTENT(OUT) :: x
    REAL*8, INTENT(OUT) :: y
    REAL*8, INTENT(OUT) :: z
END FUNCTION

!> \ingroup h5blockf_attrib
!! See \ref H5Block3dSetFieldOrigin
!! \return 0 on success or error code
!<
INTEGER*8 FUNCTION h5bl_3d_set_field_origin(filehandle, name, x, y, z)
    INTEGER*8, INTENT(IN) :: filehandle
    CHARACTER(LEN=*), INTENT(IN) :: name
    REAL*8, INTENT(IN) :: x
    REAL*8, INTENT(IN) :: y
    REAL*8, INTENT(IN) :: z
END FUNCTION

