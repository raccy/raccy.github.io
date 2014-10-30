#!/bin/sh
g++-4.9 -std=c++14 -c -o hello.o hello.cpp
g++-4.9 -o hello hello.o
./hello
rm hello.o hello
