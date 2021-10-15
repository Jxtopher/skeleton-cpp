![Build](https://github.com/Jxtopher/skeleton-cpp/actions/workflows/build.yml/badge.svg) 
<a href="#"><img src="https://img.shields.io/badge/C++-20-blue.svg?style=flat-square"></a>
--------------------------------
# Skeleton C++

## Who use ?

Install packages

```bash
sudo apt-get -y install libcppunit-dev cppcheck clang-format-11 clang-tidy-11 libboost-program-options-dev
```

Change the project name in CMakeLists.txt

```cmake
project(Your name projet)
```

Compile the project

```bash
cd build
cmake ..
make
```

Run app

```bash
make run
```

## Commands available

| Command                | Explication                                     |
|------------------------|-------------------------------------------------|
| make run               |  run main application                           |
| make test              |  run all tests                                  |
| make cppcheck          |  run cppcheck                                   |
| make clang-format      |  run clang-format-11                            |
| make example.test      |  run single test in particular **example.test** |       


## References
- https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines

