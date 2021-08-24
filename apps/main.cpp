#include <cstdlib>
#include <iostream>

#include "args_parser.h"

int main(int argc, char** argv, char** envp) {
    Args args = args_parser(argc, argv);
    std::cout << "File configuration : " << args.config << std::endl;
    return EXIT_SUCCESS;
}
