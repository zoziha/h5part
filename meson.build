project(
    'h5part',
    'fortran', 'c',
    version : '1.0.0',
    license : 'BSD-3-Clause',
    default_options : ['buildtype=debugoptimized'],
)

src = files(
    'src/h5part.f90',
    'h5part/src/H5Part.c',
    'h5part/src/H5PartF.c',
    'h5part/src/H5PartAttrib.c',
    'h5part/src/H5PartAttribF.c',
)

h5part_inc = include_directories(
    'h5part/inc',
    'h5part/include',
)

h5part_lib = library(
    meson.project_name(),
    src,
    include_directories : h5part_inc,
    dependencies : [
        dependency('hdf5', language : 'c', version : '>= 1.10.6'),
    ],
    version : meson.project_version(),
    install : true,
)

h5part_pinc = h5part_lib.private_dir_include()
h5part_dep = declare_dependency(
    include_directories : h5part_pinc,
    link_with : h5part_lib,
)

testdrive_dep = subproject('test-drive').get_variable('testdrive_dep')
test_lib = library(
    'test_lib',
    'test/test_h5part.f90',
    dependencies : [
        h5part_dep,
        testdrive_dep,
    ],
)

test(
    'h5part',
    executable(
        'h5part',
        'test/tester.f90',
        dependencies : [
            testdrive_dep,
        ],
        link_with : test_lib,
    ),
    workdir : meson.current_source_dir(),
    args : ['test.h5part'],
)