#!/bin/bash
set +o pipefail
executable=$1
outputfile=${executable////_}  # strip out /es if executable is full path
tee "/tmp/$outputfile.in" | "$@" 2>"/tmp/$outputfile.err" | tee "/tmp/$outputfile.out"
# script --return --quiet --log-in "/tmp/$outputfile.in" --log-out "/tmp/$outputfile.out" --comand sh -c "$@" 2> "/tmp/$outputfile.err"
