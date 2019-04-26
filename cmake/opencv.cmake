include(ExternalProject)

if (${CMAKE_SYSTEM_NAME} MATCHES "Windows")
    ExternalProject_Add(
        opencv
        URL https://github.com/opencv/opencv/archive/4.1.0.zip
        INSTALL_COMMAND MSBuild INSTALL.vcxproj
        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_SOURCE_DIR}
                -DWITH_QT=OFF
                -DWITH_CUDA=OFF
                -DBUILD_EXAMPLES=OFF
                -DBUILD_DOCS=OFF
                -DBUILD_TESTS=OFF
                -DBUILD_PREFTESTS=OFF
                -DBUILD_SHARED_LIBS=OFF
                -DBUILD_opencv_world=ON)
elseif (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    ExternalProject_Add(
        opencv
        URL https://github.com/opencv/opencv/archive/4.1.0.zip
        INSTALL_COMMAND make install
        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_SOURCE_DIR}
                -DWITH_QT=OFF
                -DWITH_CUDA=OFF
                -DWITH_LAPACK=OFF
                -DWITH_OPENCL=OFF
                -DBUILD_EXAMPLES=OFF
                -DBUILD_DOCS=OFF
                -DBUILD_TESTS=OFF
                -DBUILD_PREFTESTS=OFF
                -DBUILD_SHARED_LIBS=OFF)
    set(OPENCV_DEPENDENCY_LIBS libdl.dylib)
else()
    ExternalProject_Add(
        opencv
        URL https://github.com/opencv/opencv/archive/4.1.0.zip
        INSTALL_COMMAND make install
        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_SOURCE_DIR}
                -DWITH_QT=OFF
                -DWITH_CUDA=OFF
                -DBUILD_EXAMPLES=OFF
                -DBUILD_DOCS=OFF
                -DBUILD_TESTS=OFF
                -DBUILD_PREFTESTS=OFF
                -DBUILD_SHARED_LIBS=OFF)
    set(OPENCV_DEPENDENCY_LIBS libpthread.so;libdl.so)
endif()

if (${CMAKE_SYSTEM_NAME} MATCHES "Windows")
else()
    file(GLOB OPENCV_LIBS ${CMAKE_SOURCE_DIR}/lib/libopencv_*.a)
    list(REMOVE_ITEM OPENCV_LIBS ${CMAKE_SOURCE_DIR}/lib/libopencv_core.a)
    list(APPEND OPENCV_LIBS ${CMAKE_SOURCE_DIR}/lib/libopencv_core.a)
    file(GLOB OPENCV_THIRDPARTY_LIBS ${CMAKE_SOURCE_DIR}/lib/opencv4/3rdparty/*.a)
    list(REMOVE_ITEM OPENCV_THIRDPARTY_LIBS ${CMAKE_SOURCE_DIR}/lib/opencv4/3rdparty/libippiw.a)
    list(INSERT OPENCV_THIRDPARTY_LIBS 0 ${CMAKE_SOURCE_DIR}/lib/opencv4/3rdparty/libippiw.a)
    list(APPEND OPENCV_LIBS ${OPENCV_THIRDPARTY_LIBS})
    list(APPEND OPENCV_LIBS ${OPENCV_DEPENDENCY_LIBS})
endif()


ExternalProject_Get_Property(opencv source_dir)
include_directories(${CMAKE_SOURCE_DIR}/include/opencv4)

ExternalProject_Get_Property(opencv binary_dir)
