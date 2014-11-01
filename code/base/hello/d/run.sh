#!/bin/sh
dmd -c hello.d
dmd hello.o
./hello
rm hello.o hello
