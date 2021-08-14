#include "args_parser.h"

Args args_parser(int argc, char** argv) {
    Args ret_args;

    boost::program_options::variables_map vm;
    boost::program_options::options_description args(
        "**" + std::string(NAME_SOFTWARE) + "**" + " options");
    args.add_options()("help,h", "help message")("version,v", "version")(
        "config,c",
        boost::program_options::value<std::string>(&ret_args.config),
        "file configuration json (default : \"\")");
    try {
        boost::program_options::store(
            boost::program_options::parse_command_line(argc, argv, args), vm);
        boost::program_options::notify(vm);
    } catch (const boost::program_options::error& ex) {
        throw std::runtime_error(std::string{} + __FILE__ + ":" +
                                 std::to_string(__LINE__) +
                                 " [-] error program_options " + ex.what());
    }

    if (vm.count("version")) {
        version(NAME_SOFTWARE);
        exit(EXIT_SUCCESS);
    }

    if (vm.count("help")) {
        std::cout << args << std::endl;
        exit(EXIT_SUCCESS);
    }

    return ret_args;
}
