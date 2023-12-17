#!/bin/bash 

c++ -std=gnu++2a -Wall -g -O3 sandbox.cc -o sandbox "$@" && ./sandbox
