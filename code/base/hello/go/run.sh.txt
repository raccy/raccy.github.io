#!/bin/sh
GOPATH=`pwd` go build hello
./hello
rm hello
