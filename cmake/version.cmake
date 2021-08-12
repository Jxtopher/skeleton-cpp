###############################################################################
# Get info git and genereted version.h from version.h.in./ 
###############################################################################
if (NOT EXISTS "${CMAKE_BINARY_DIR}/generated/version.h.in")
    file(WRITE "${CMAKE_BINARY_DIR}/generated/version.h.in" "#ifndef VERSION_H
#define VERSION_H

#define GIT_BRANCH \"\@GIT_BRANCH\@\"
#define GIT_COMMIT_HASH \"\@GIT_COMMIT_HASH\@\"
#define CMAKE_BUILD_TYPE \"\@CMAKE_BUILD_TYPE\@\"
#define VERSION_PROJECT \"\@VERSION_PROJECT\@\"

#include <iostream>

void version(const std::string& name_software) {
    std::cout << \"******************************************\" << std::endl;
    std::cout << \"[+] *** \" << name_software << \" ***\" << std::endl;
    std::cout << \"[+] Day compilation : \" << __DATE__ << \" \" << __TIME__ << std::endl;
    std::cout << \"[+] Version (\" << CMAKE_BUILD_TYPE << \") : \" << VERSION_PROJECT << std::endl;
    std::cout << \"[+] Git branch : \" << GIT_BRANCH << std::endl;
    std::cout << \"[+] Git commit hash : \" << GIT_COMMIT_HASH << std::endl;
    std::cout << \"******************************************\" << std::endl;
}

#endif
")
endif(NOT EXISTS "${CMAKE_BINARY_DIR}/generated/version.h.in")

if(EXISTS "${CMAKE_SOURCE_DIR}/.git")
  execute_process(
    COMMAND git rev-parse --abbrev-ref HEAD
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_VARIABLE GIT_BRANCH
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )

  execute_process(
    COMMAND git log -1 --format=%h
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_VARIABLE GIT_COMMIT_HASH
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )

  execute_process(
    COMMAND (git describe --tags 2>/dev/null)
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_VARIABLE VERSION_PROJECT
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
  
else(EXISTS "${CMAKE_SOURCE_DIR}/.git")
  set(GIT_BRANCH "")
  set(GIT_COMMIT_HASH "")
endif(EXISTS "${CMAKE_SOURCE_DIR}/.git")

configure_file(
  ${CMAKE_BINARY_DIR}/generated/version.h.in
  ${CMAKE_BINARY_DIR}/generated/version.h
)

include_directories(${CMAKE_BINARY_DIR}/generated)
