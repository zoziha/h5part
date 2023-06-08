project(
    'h5part',
    'fortran', 'c',
    version : '1.1.20230513',
    license : 'BSD-3-Clause',
    default_options : [
        'buildtype=debugoptimized',
        'fortran_std=f2008',
        'default_library=both',
    ],
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

h5part_lic = files(
    'LICENSE-BSD',
    'h5part/LICENSE',
)
install_data(
    h5part_lic,
    install_dir : join_paths(get_option('datadir'), 'licenses', meson.project_name()),
)

if host_machine.system() == 'windows'
    symbols_file = 'lib'+meson.project_name()+'-'+meson.project_version().split('.')[0]+'.dll.symbols'
    obj_suffix = '.obj'
else
    symbols_file = 'lib'+meson.project_name()+'.so.'+meson.project_version()+'.symbols'
    obj_suffix = '.o'
endif
install_subdir(h5part_lib.full_path()+'.p',
    install_dir: 'include'/meson.project_name(),
    strip_directory: true,
    exclude_files: [
        'depscan.dd',
        meson.project_name()+'-deps.json',
        symbols_file,
        meson.project_name()+'.dat',
        'src_h5part.f90'+obj_suffix,
        'h5part_src_H5PartAttrib.c'+obj_suffix,
        'h5part_src_H5PartAttribF.c'+obj_suffix,
        'h5part_src_H5Part.c'+obj_suffix,
        'h5part_src_H5PartF.c'+obj_suffix,
    ]
)

pkg = import('pkgconfig')
pkg.generate(
    h5part_lib,
    name: meson.project_name(),
    description: 'H5PART is a structured HDF5 data format',
    version: meson.project_version(),
    subdirs: meson.project_name(),
)

testdrive_dep = dependency('test-drive', required: false, method: 'pkg-config')
if not testdrive_dep.found()
    testdrive_dep = subproject('test-drive').get_variable('testdrive_dep')
endif
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