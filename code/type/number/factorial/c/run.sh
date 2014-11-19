#!/bin/sh
gcc-4.9 -Wall -O3 -std=c11 -c -o factorial.o factorial.c
gcc-4.9 -o factorial factorial.o
./factorial
#rm *.o factorial
