## > clang-format ##################################################################
set(CLANG_FORMAT_TO_APPLY "apps/*.cpp"
                          "include/*.cpp" 
                          "include/*.h" 
                          "include/*.hpp" 
                          "src/*.cpp" 
                          "src/*.h" 
                          "src/*.hpp" 
                          "test/unit/*.cpp" 
                          "test/unit/*.h" 
                          "test/unit/*.hpp") 

FIND_PROGRAM(CLANGFORMAT_EXECUTABLE clang-format-11)

file(GLOB_RECURSE ALL_SOURCE_FILES  ${CLANG_FORMAT_TO_APPLY})
foreach (SOURCE_FILE ${ALL_SOURCE_FILES})
    string(FIND ${SOURCE_FILE} ${PROJECT_TRDPARTY_DIR} PROJECT_TRDPARTY_DIR_FOUND)
    if (NOT ${PROJECT_TRDPARTY_DIR_FOUND} EQUAL -1)
        list(REMOVE_ITEM ALL_SOURCE_FILES ${SOURCE_FILE})
    endif ()
endforeach ()

add_custom_target(
        clang-format
        COMMAND ${CLANGFORMAT_EXECUTABLE}
        -style=file
        -i 
        ${ALL_SOURCE_FILES}
)
## < clang-format-11
