#!/bin/shqs
gcc -std=c11 -c -o hello.o hello.c
gcc -o hello hello.o
./hello
rm hello.o hello
