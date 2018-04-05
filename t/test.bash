#!/usr/bin/env bash

test_count=0

test_file_at_width() {
    local result_file=$(mktemp);
    local run_dir=$(dirname $0)
    local expected_result="$run_dir/data/${1%in}$2-col.out"

    "$run_dir/../bin/two-cols" "-t$2" < "$run_dir/data/$1" >"$result_file"
    ((test_count++))

    if diff "$result_file" "$expected_result" ; then
        echo ok $test_count
        rm $result_file
    else
        echo differences above between result in "$result_file" and expected result in "$expected_result"
        echo not ok $test_count
    fi
}

test_file_at_width 01-original-post.in 80
test_file_at_width 05-three-recs.in 80
test_file_at_width 05-three-recs.in 60
test_file_at_width 05-three-recs.in 40
test_file_at_width 07-three-recs-wrap.in 80
test_file_at_width 10-longer-second-column.in 80
