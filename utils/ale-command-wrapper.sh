#!/bin/sh
tee "$1.in" | "$@" 2>"$1.err" | tee "$1.out"
