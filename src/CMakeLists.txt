add_executable(main main.cpp)

file(GLOB OPENCV_THIRDPARTY_LIBS ${CMAKE_SOURCE_DIR}/lib/opencv4/3rdparty/*.a)
file(GLOB OPENCV_LIBS ${CMAKE_SOURCE_DIR}/lib/libopencv_*.a)

target_link_libraries(main
    ${OPENCV_LIBS}
    ${OPENCV_THIRDPARTY_LIBS}
    ${OPENCV_DEPENDENCIES_LIBS}
)