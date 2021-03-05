#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

script=ansible-1line-converter

cd tests

for t in $(ls *.test|sort -n); do
    test_name=${t/.test/}
    test_expected_out=${t/.test/.expected_out}
    test_desc=${t/.test/.desc}
    test_desc_text=$(if [ -f $test_desc ]; then cat $test_desc; fi)
    test_current_out=test.out
    if [ ! -f "$test_expected_out" ]; then
        echo expected output for $test_name missing. Skipping test
        continue
    fi
    echo runnng test $test_name
    ../$script $t > $test_current_out
    if diff -q $test_current_out $test_expected_out &>/dev/null; then
        echo -e "  test $test_name ${GREEN}passed${NC} ($test_desc_text)"
    else                                                 
        echo -e "  test $test_name ${RED}failed${NC} <<<<<<<<<<<<<<<<<<<<< ($test_desc_text)"
    fi
    rm -f $test_current_out
done

cd ..
