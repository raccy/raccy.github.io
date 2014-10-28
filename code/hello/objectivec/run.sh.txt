#!/bin/sh
clang -c -o hello.o hello.m
clang -o hello hello.o -framework Foundation
./hello
rm hello.o hello
