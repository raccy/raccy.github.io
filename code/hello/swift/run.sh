#!/bin/sh
swiftc hello.swift -sdk `xcrun --show-sdk-path --sdk macosx`
./hello
rm hello
