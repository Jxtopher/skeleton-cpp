cmake_minimum_required(VERSION 3.12)

###############################################################################
# Set of compilator parameters
###############################################################################
project(skeleton-cpp)

set(CMAKE_CXX_STANDARD 20) #-std=c++2a 
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_COMPILER_LAUNCHER "ccache")

if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  # using Clang
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  # using GCC
  set(FLAGS "-pedantic -Wall -Wextra -Wcast-align -Wctor-dtor-privacy \
  -Wdisabled-optimization -Wformat=2 -Winit-self -Wlogical-op \
  -Wmissing-include-dirs -Wno-unused -Wshadow \
  -Woverloaded-virtual -Wredundant-decls -Wsign-promo \
  -Wstrict-null-sentinel -Wstrict-overflow=2 -Wundef -Werror \
  -Wswitch-default -Wsign-conversion -Wcast-qual -Wold-style-cast") # -Wmissing-declarations 
  set(COV_FLAGS "-fprofile-arcs -ftest-coverage")
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
  # using Intel C++
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  # using Visual Studio C++
endif()

set(CMAKE_CXX_FLAGS_DEBUG "-g3 -DDEBUG")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -DNDEBUG")


###############################################################################
# Load modules cmake
###############################################################################
set (CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
include(cppcheck)       # apply cppcheck
include(clang-format)   # apply clang-format
include(version)        # Version name generator form git branch, hash
include(doxygen)        # Create the documentation


###############################################################################
# Load modules of external libs
###############################################################################
find_package(Git QUIET)
if(Git_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
# Update submodules as needed
    option(GIT_SUBMODULE "Check submodules during build" ON)
    if(GIT_SUBMODULE)
        message(STATUS "Submodule git update")
        execute_process(COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
                        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                        RESULT_VARIABLE GIT_SUBMOD_RESULT)
        if(NOT GIT_SUBMOD_RESULT EQUAL "0")
            message(FATAL_ERROR "git submodule update --init failed with ${GIT_SUBMOD_RESULT}, please checkout submodules")
        endif()
    endif()
endif()

###############################################################################
# Get external libs
###############################################################################
find_package(PkgConfig)
find_package(Boost 1.71 COMPONENTS program_options REQUIRED)
find_package(Threads REQUIRED)
find_package(OpenMP)
if (OPENMP_FOUND)
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
    set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${OpenMP_EXE_LINKER_FLAGS}")
endif()

###############################################################################
# Library of the project
###############################################################################
set(LIBPROJECT lib${PROJECT_NAME})

# project(${LIBPROJECT} VERSION 1.0.1 DESCRIPTION "${LIBPROJECT} description")
file(GLOB_RECURSE ALL_SOURCE_FILES  "src/*.cpp")
add_library(${LIBPROJECT} SHARED ${ALL_SOURCE_FILES})

# set_target_properties(${LIBPROJECT} PROPERTIES VERSION ${PROJECT_VERSION})
set_target_properties(${LIBPROJECT} PROPERTIES PREFIX "")
set_target_properties(${LIBPROJECT} PROPERTIES SOVERSION 1)
set_target_properties(${LIBPROJECT} PROPERTIES PUBLIC_HEADER include/skeleton-cpp.h)
set_target_properties(${LIBPROJECT} PROPERTIES COMPILE_FLAGS ${FLAGS})
target_include_directories(${LIBPROJECT} PRIVATE include)
target_include_directories(${LIBPROJECT} PRIVATE src)
target_link_libraries(${LIBPROJECT} LINK_PRIVATE ${Boost_LIBRARIES})

# target_include_directories(${LIBPROJECT} PRIVATE modules)


###############################################################################
# APPS
###############################################################################
file(GLOB LIST_OF_FILES  apps/*.cpp)
foreach(PATH_FILE  ${LIST_OF_FILES})
    get_filename_component(NAME_FILE ${PATH_FILE} NAME_WE)
    add_executable(${PROJECT_NAME}-${NAME_FILE} ${PATH_FILE})

    target_include_directories(${PROJECT_NAME}-${NAME_FILE} PRIVATE include)
    target_include_directories(${PROJECT_NAME}-${NAME_FILE} PRIVATE modules)

    target_link_libraries(${PROJECT_NAME}-${NAME_FILE} ${LIBPROJECT})
    target_link_libraries(${PROJECT_NAME}-${NAME_FILE} ${PNG_LIBRARIES})
    target_link_libraries(${PROJECT_NAME}-${NAME_FILE} ${CMAKE_THREAD_LIBS_INIT})

    install(TARGETS ${PROJECT_NAME}-${NAME_FILE} ${LIBPROJECT}
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
    )
endforeach()
###############################################################################
# Tests
###############################################################################
pkg_check_modules(CPPUNIT cppunit REQUIRED)

enable_testing()
file(GLOB_RECURSE ALL_SOURCE_FILES  "test/unit/*.cpp")
foreach (SOURCE_FILE ${ALL_SOURCE_FILES})
    get_filename_component(NAME_FILE ${SOURCE_FILE} NAME_WE)
    add_executable(${NAME_FILE}.test ${SOURCE_FILE})
    target_link_libraries(${NAME_FILE}.test LINK_PRIVATE
        ${CPPUNIT_LIBRARIES}
        ${LIBPROJECT}
        gcov)
    target_include_directories(${NAME_FILE}.test PRIVATE 
        "include/"
        "/usr/local/include/"
    )
    set_target_properties(${NAME_FILE}.test PROPERTIES COMPILE_FLAGS "${FLAGS} ${COV_FLAGS}")
    add_test(NAME ${NAME_FILE} COMMAND ${NAME_FILE}.test WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})
endforeach()

###############################################################################
# Globals tests
###############################################################################
find_package (Python3 COMPONENTS Interpreter Development)

file(GLOB LIST_OF_FILES  test/integration/*.py)
foreach(PATH_FILE  ${LIST_OF_FILES})
    get_filename_component(FILE ${PATH_FILE} NAME)
    add_test(NAME ${FILE} COMMAND ${Python3_EXECUTABLE} ${PATH_FILE} "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-main" WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})
endforeach()
