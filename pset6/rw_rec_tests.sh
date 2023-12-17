#!/bin/bash

make

for _ in {0..100}; do
	./rw_rec_test_1
done
