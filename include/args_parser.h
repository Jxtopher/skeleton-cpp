#ifndef ARGS_PARSER_H
#define ARGS_PARSER_H

#include <boost/program_options.hpp>
#include <cstdlib>
#include <iostream>

#include "global.h"
#include "version.h"

struct Args {
    std::string config;
};

Args args_parser(int argc, char** argv);

#endif
