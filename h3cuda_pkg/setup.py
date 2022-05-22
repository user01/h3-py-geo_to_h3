# Modified from
# https://github.com/rmcgibbo/npcuda-example
# Which is BSD-2-Clause license
# https://github.com/rmcgibbo/npcuda-example/blob/master/LICENSE

# License reproduced here: Copyright (c) 2014, Robert T. McGibbon and the Authors All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification, are permitted provided that the
# following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following
#    disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the
#    following disclaimer in the documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import os
from os.path import join as pjoin
from pathlib import Path

from Cython.Distutils import build_ext
from setuptools import Extension, setup

# from Cython.Build import cythonize
import numpy


# NOTE: These architecture flags are based on CUDA 11.1 for best performance with RTX 30*
# Adjustments may be required for specific architecture
ARCH_FLAGS = [
    "-arch=sm_80",
    "-gencode=arch=compute_80,code=sm_80",
    "-gencode=arch=compute_86,code=sm_86",
    "-gencode=arch=compute_87,code=sm_87",
    "-gencode=arch=compute_87,code=compute_87",
]
GCC_OVERRIDE = [
    "-ccbin=/usr/local/cuda/bin/gcc",
    # NOTE: Had to force this to gcc 7 on current system, but not in CI
]

def find_in_path(name, path):
    """Find a file in a search path"""

    # Adapted fom http://code.activestate.com/recipes/52224
    for dir in path.split(os.pathsep):
        binpath = pjoin(dir, name)
        if os.path.exists(binpath):
            return os.path.abspath(binpath)
    return None


def locate_cuda():
    """Locate the CUDA environment on the system

    Returns a dict with keys 'home', 'nvcc', 'include', and 'lib64'
    and values giving the absolute path to each directory.

    Starts by looking for the CUDAHOME env variable. If not found,
    everything is based on finding 'nvcc' in the PATH.
    """

    # First check if the CUDAHOME env variable is in use
    if "CUDAHOME" in os.environ:
        home = os.environ["CUDAHOME"]
        nvcc = pjoin(home, "bin", "nvcc")
    else:
        # Otherwise, search the PATH for NVCC
        nvcc = find_in_path("nvcc", os.environ["PATH"])
        if nvcc is None:
            raise EnvironmentError(
                "The nvcc binary could not be "
                "located in your $PATH. Either add it to your path, "
                "or set $CUDAHOME"
            )
        home = os.path.dirname(os.path.dirname(nvcc))

    cudaconfig = {"home": home, "nvcc": nvcc, "include": pjoin(home, "include"), "lib64": pjoin(home, "lib64")}
    for k, v in iter(cudaconfig.items()):
        if not os.path.exists(v):
            raise EnvironmentError("The CUDA %s path could not be " "located in %s" % (k, v))

    return cudaconfig


def customize_compiler_for_nvcc(self):
    """Inject deep into distutils to customize how the dispatch
    to gcc/nvcc works.

    If you subclass UnixCCompiler, it's not trivial to get your subclass
    injected in, and still have the right customizations (i.e.
    distutils.sysconfig.customize_compiler) run on it. So instead of going
    the OO route, I have this. Note, it's kindof like a wierd functional
    subclassing going on.
    """

    # Tell the compiler it can processes .cu
    self.src_extensions.append(".cu")

    # Save references to the default compiler_so and _comple methods
    default_compiler_so = self.compiler_so
    super = self._compile

    # Now redefine the _compile method. This gets executed for each
    # object but distutils doesn't have the ability to change compilers
    # based on source extension: we add it.
    def _compile(obj, src, ext, cc_args, extra_postargs, pp_opts):
        if os.path.splitext(src)[1] == ".cu":
            # use the cuda for .cu files
            self.set_executable("compiler_so", CUDA["nvcc"])
            # use only a subset of the extra_postargs, which are 1-1
            # translated from the extra_compile_args in the Extension class
            postargs = extra_postargs["nvcc"]
        else:
            postargs = extra_postargs["gcc"]

        super(obj, src, ext, cc_args, postargs, pp_opts)
        # Reset the default compiler_so, which we might have changed for cuda
        self.compiler_so = default_compiler_so

    # Inject our redefined _compile method into the class
    self._compile = _compile


# Run the customize_compiler
class custom_build_ext(build_ext):
    def build_extensions(self):
        customize_compiler_for_nvcc(self.compiler)
        build_ext.build_extensions(self)


CUDA = locate_cuda()

# Obtain the numpy include directory. This logic works across numpy versions.
numpy_include = numpy.get_include()


ext = Extension(
    "h3cuda",
    sources=["src/manager.cu", "wrapper.pyx"],
    library_dirs=[CUDA["lib64"]],
    libraries=["cudart"],
    language="c++",
    runtime_library_dirs=[CUDA["lib64"]],
    # This syntax is specific to this build system
    # we're only going to use certain compiler args with nvcc
    # and not with gcc the implementation of this trick is in
    # customize_compiler()
    extra_compile_args={
        "gcc": [],
        "nvcc": ARCH_FLAGS + GCC_OVERRIDE + [
            # "-g",  # Debug flags - remove in prod
            # "-G",  # Debug flags - remove in prod
            "--ptxas-options=-v",
            "-c",
            "--compiler-options",
            "'-fPIC'",
        ],
    },
    include_dirs=[numpy_include, CUDA["include"], "src"],
)


this_directory = Path(__file__).parent
long_description = (this_directory / "README.md").read_text()

setup(
    name="h3cuda",
    author="Erik Langenborg",
    version="0.1.0",
    ext_modules=[ext],
    # Inject our custom trigger
    cmdclass={"build_ext": custom_build_ext},
    # Since the package has c code, the egg cannot be zipped
    zip_safe=False,
    long_description=long_description,
    long_description_content_type="text/markdown",
)
