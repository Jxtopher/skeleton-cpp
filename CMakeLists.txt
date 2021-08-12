cmake_minimum_required(VERSION 3.12)

###############################################################################
# Set of compilator parameters
###############################################################################
project(toto)

set(CMAKE_BUILD_TYPE Release) # (Release|Debug)
set(CMAKE_CXX_STANDARD 20) #-std=c++2a 
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(FLAGS "-pthread -fopenmp \
-pedantic -Wall -Wextra -Wcast-align -Wctor-dtor-privacy \
-Wdisabled-optimization -Wformat=2 -Winit-self -Wlogical-op \
-Wmissing-include-dirs -Wnoexcept -Wno-unused -Wshadow \
-Woverloaded-virtual -Wredundant-decls -Wsign-promo \
-Wstrict-null-sentinel -Wstrict-overflow=5 -Wundef -Werror \
-Wswitch-default -Wsign-conversion -Wcast-qual -Wold-style-cast") # -Wmissing-declarations 
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
# LIBRARIES Alpha-graph
###############################################################################
set(LIBPROJECT lib${PROJECT_NAME})

# project(${LIBPROJECT} VERSION 1.0.1 DESCRIPTION "${LIBPROJECT} description")
file(GLOB_RECURSE ALL_SOURCE_FILES  "src/*.cpp")
add_library(${LIBPROJECT} SHARED ${ALL_SOURCE_FILES})

# set_target_properties(${LIBPROJECT} PROPERTIES VERSION ${PROJECT_VERSION})
set_target_properties(${LIBPROJECT} PROPERTIES SOVERSION 1)
set_target_properties(${LIBPROJECT} PROPERTIES PUBLIC_HEADER include/alphagraph.h)
set_target_properties(${LIBPROJECT} PROPERTIES COMPILE_FLAGS ${FLAGS})
set_target_properties(${LIBPROJECT} PROPERTIES CMAKE_STATIC_LIBRARY_PREFIX "")

target_include_directories(${LIBPROJECT} PRIVATE include)
target_include_directories(${LIBPROJECT} PRIVATE src)
# target_include_directories(${LIBPROJECT} PRIVATE modules)

###############################################################################
# Get external libs
###############################################################################
find_package(PkgConfig)


###############################################################################
# APPS
###############################################################################
add_executable(${PROJECT_NAME} apps/main.cpp)

target_include_directories(${PROJECT_NAME} PRIVATE include)
target_include_directories(${PROJECT_NAME} PRIVATE modules)

target_link_libraries(${PROJECT_NAME} ${LIBPROJECT})

###############################################################################
# Tests
###############################################################################
pkg_check_modules(CPPUNIT cppunit)
link_libraries(${CPPUNIT_LIBRARIES})

enable_testing()
file(GLOB_RECURSE ALL_SOURCE_FILES  "test/unit/*.cpp")
foreach (SOURCE_FILE ${ALL_SOURCE_FILES})
    get_filename_component(NAME_FILE ${SOURCE_FILE} NAME_WE)
    add_executable(${NAME_FILE}.test ${SOURCE_FILE})
    target_link_libraries(${NAME_FILE}.test LINK_PRIVATE
    ${LIBPROJECT})
    target_include_directories(${NAME_FILE}.test PRIVATE 
        "include/"
        "/usr/local/include/"
    )
    set_target_properties(${NAME_FILE}.test PROPERTIES COMPILE_FLAGS ${FLAGS})
    add_test(NAME ${NAME_FILE} COMMAND ${NAME_FILE}.test WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})
endforeach()

###############################################################################
# Globals tests
###############################################################################
find_package (Python3 COMPONENTS Interpreter Development)

file(GLOB LIST_OF_FILES  test/integration/*.py)
foreach(PATH_FILE  ${LIST_OF_FILES})
    get_filename_component(FILE ${PATH_FILE} NAME)
    add_test(NAME ${FILE} COMMAND ${Python3_EXECUTABLE} ${PATH_FILE} "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}" WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})
endforeach()


###############################################################################
# Install
###############################################################################
install(TARGETS ${PROJECT_NAME} ${STOCOS_CONTINUOUS_PROBLEM_LIBRARIES} ${STOCOS_LIBRARIES}
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    PUBLIC_HEADER DESTINATION include/stocos
)
