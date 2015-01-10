#!/bin/sh
g++-4.9 -Wall -O3 -std=c++14 -c -o integer.o integer.cpp
g++-4.9 -o integer integer.o
./integer
rm integer.o integer
