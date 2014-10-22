#!/bin/sh
erlc hello.erl
erl -noshell -s hello main -s init stop
rm hello.beam
