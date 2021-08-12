## > cppcheck ##################################################################
set(CPPCHECK_TO_APPLY     "include/*.h"
                          "apps/*.cpp"  
                          "src/*.cpp" 
                          "src/*.h" 
                          "src/*.hpp" 
                          "tests/unit/*.cpp" 
                          "test/unit/*.h" 
                          "test/unit/*.hpp") 

## Detection du programme cppcheck
FIND_PROGRAM(CPPCHECK_EXECUTABLE cppcheck)

SET(PROJECT_TRDPARTY_DIR third-party)

# file(GLOB_RECURSE ALL_SOURCE_FILES ${CPPCHECK_TO_APPLY})
# foreach (SOURCE_FILE ${ALL_SOURCE_FILES})
#     string(FIND ${SOURCE_FILE} ${PROJECT_TRDPARTY_DIR} PROJECT_TRDPARTY_DIR_FOUND)
#     if (NOT ${PROJECT_TRDPARTY_DIR_FOUND} EQUAL -1)
#         list(REMOVE_ITEM ALL_SOURCE_FILES ${SOURCE_FILE})
#     endif ()
# endforeach ()

add_custom_target(
        cppcheck
        COMMAND ${CPPCHECK_EXECUTABLE} --enable=all --error-exitcode=1 --quiet --template="[{severity}][{id}] {message} {callstack} \(On {file}:{line}\)" --language=c++  --std=c++11  -I ../include/ -I ./generated/  ../src/* ../apps 
)
## < cppcheck


# --std=c++11 
# --language=c++ 
# --suppress=missingIncludeSystem
# --template="[{severity}][{id}] {message} {callstack} \(On {file}:{line}\)"
# --verbose
# --check-config
# --quiet
