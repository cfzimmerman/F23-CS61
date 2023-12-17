#!/bin/bash

make

for _ in {0..100}; do
	./mpsc_test_1
done

for _ in {0..50}; do
	./mpsc_test_2
done

for _ in {0..50}; do
	./mpsc_test_3
done

for _ in {0..50}; do
	./mpsc_test_4
done
