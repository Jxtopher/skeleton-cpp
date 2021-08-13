## > cppcheck ##################################################################
set(CPPCHECK_TO_APPLY     "include/*.h"
                          "apps/*.cpp"  
                          "src/*.cpp" 
                          "src/*.h" 
                          "src/*.hpp" 
                          "test/unit/*.cpp" 
                          "test/unit/*.h" 
                          "test/unit/*.hpp") 

FIND_PROGRAM(CPPCHECK_EXECUTABLE cppcheck)

SET(PROJECT_TRDPARTY_DIR third-party)

add_custom_target(
        cppcheck
        COMMAND ${CPPCHECK_EXECUTABLE} --enable=all  --suppressions-list=../cppcheck-suppress --error-exitcode=1 --quiet --template="[{severity}][{id}] {message} {callstack} \(On {file}:{line}\)" --language=c++  --std=c++11  -I ../include/ -I ./generated/  ../src/* ../apps test/unit/*
)
## < cppcheck
