cmake_minimum_required(VERSION 2.8.4)
set(name fac)
project(${name})

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

add_custom_target(${name} COMMAND make -C ${${name}_SOURCE_DIR}
        CLION_EXE_DIR=${PROJECT_BINARY_DIR})

add_executable(cpsc221_lab_dict
        anagram_dict.cpp
        anagram_finder.cpp
        cartalk_puzzle.cpp
        fac.cpp
        fib.cpp
        fib_generator.cpp
        common_words.cpp
        find_common_words.cpp
        find_common_words.cpp
        homophone_puzzle.cpp
        pronounce_dict.cpp)