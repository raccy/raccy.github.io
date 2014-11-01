#!/bin/sh
gcc-4.9 -std=c11 -c -o hello.o hello.c
gcc-4.9 -o hello hello.o
./hello
rm hello.o hello
