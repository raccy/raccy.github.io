#!/bin/sh
g++ -std=c++11 -c -o hello.o hello.cpp
g++ -o hello hello.o
./hello
rm hello.o hello
