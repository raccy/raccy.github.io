#!/bin/sh
gcc-4.9  -ftrapv  -O3 -Wall -std=c11 -c -o integer.o integer.c
gcc-4.9 -o integer integer.o
./integer
rm integer.o integer
