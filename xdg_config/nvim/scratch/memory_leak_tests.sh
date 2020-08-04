#!/bin/bash



export CACHE_ENABLE=true
export BASE_DIR="$HOME/build/ubsan_nvim"
export BUILD_DIR="$BASE_DIR/build"
export DEPS_BUILD_DIR="$BASE_DIR/nvim-deps"
export INSTALL_PREFIX="$BASE_DIR/nvim-install"
export LOG_DIR="$BASE_DIR/nvimlog"
export NVIM_LOG_FILE="$BUILD_DIR/.nvimlog"
export CMAKE_FLAGS="-DTRAVIS_CI_BUILD=ON
                    -DCMAKE_BUILD_TYPE=Debug
                    -DCMAKE_INSTALL_PREFIX:PATH=$INSTALL_PREFIX
                    -DBUSTED_OUTPUT_TYPE=nvim
                    -DDEPS_PREFIX=$DEPS_BUILD_DIR/usr
                    -DMIN_LOG_LEVEL=3
                    -DCLANG_MSAN=ON
                    -DCLANG_TSAN=ON
                    -DCLANG_UBSAN=ON
                    "
export DEPS_CMAKE_FLAGS="-DUSE_BUNDLED_GPERF=OFF"
export ASAN_OPTIONS="detect_leaks=1:check_initialization_order=1:log_path=$LOG_DIR/asan"
export TSAN_OPTIONS="log_path=$LOG_DIR/tsan"
export UBSAN_OPTIONS="print_stacktrace=1 log_path=$LOG_DIR/ubsan"
export VALGRIND_LOG="$LOG_DIR/valgrind-%p.log"
export FUNCTIONALTEST=functionaltest
export CI_TARGET=tests
export CLANG_SANITIZER=ASAN_UBSAN
export CMAKE_FLAGS="$CMAKE_FLAGS -DPREFER_LUA=ON"

export CACHE_NVIM_DEPS_DIR="$HOME/.cache/nvim-deps"
export CACHE_MARKER="$CACHE_NVIM_DEPS_DIR/.travis_cache_marker"
export CCACHE_COMPRESS=1
export CCACHE_SLOPPINESS=time_macros,file_macro
export CCACHE_BASEDIR="$TRAVIS_BUILD_DIR"
export CCACHE_CPP2=1
export FOR_TRAVIS_CACHE=v1-$TRAVIS_BRANCH
export TRAVIS_COMPILER=clang
export CC=${CC:-clang}
export CC_FOR_BUILD=${CC_FOR_BUILD:-clang}
export PATH=/usr/lib/ccache:$PATH
