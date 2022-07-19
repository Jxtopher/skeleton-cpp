# Skeleton C++
![Build](https://github.com/Jxtopher/skeleton-cpp/actions/workflows/build.yml/badge.svg) 
<a href="#"><img src="https://img.shields.io/badge/C++-20-blue.svg?style=flat-square"></a>

You can use this project as template for start a new CPP project. We follow:
 - CPP [Guid lines](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines).
 - a beautiful CI/CD with Github action
 - unit test and integration test with Python
 - Dockerizing for the production and developpement environnement

## Architecture

| Directory              | Explanation                                                                                          |
|------------------------|------------------------------------------------------------------------------------------------------|
| apps/                  | you can have several files each with the main function, an executable is generated for each of them  |
| include/               | container all *.hpp and *.h                                                                          |
| src/                   | container all *.cpp                                                                                  |
| test/                  | unit tests and integration tests                                                                     |


## Ready to code via a container

You can activate the development environment in using VScode, the "Remote - Containers" plugin[^1]  and Docker and open. In VScode open the directory in container. 

[^1]: ms-vscode-remote.remote-containers

## Usages 

You can compile and execute the program as follow

Install packages

```bash
sudo apt-get -y install ccache pkg-config libcppunit-dev cppcheck clang-format-11 clang-tidy-11 libboost-program-options-dev
```

Change the project name in CMakeLists.txt

```cmake
project(Your project name)
```

Compile the project

```bash
cd build
cmake ..
make
```

Run the application

```bash
make run
```

##  Available commands

| Command                | Explanation                                     |
|------------------------|-------------------------------------------------|
| make run               |  run main application                           |
| make test              |  run all tests                                  |
| make cppcheck          |  run cppcheck                                   |
| make clang-format      |  run clang-format-11                            |
| make example.test      |  run single test in particular **example.test** |       


## References
- https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines

