#!/bin/sh
ghc Hello >/dev/null
./hello
rm Hello Hello.o Hello.hi
