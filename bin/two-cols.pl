#!/usr/bin/env perl

use strict;
use warnings;
use v5.10;
use Getopt::Std;

use vars '$opt_t';
getopt 't:';

my $terminal_width = $opt_t // `tput cols`;
die "Could not determine terminal width, try -t option.\n"
    unless $terminal_width =~ /^\d+$/;
my $col_width = int $terminal_width / 2;
my $split_fmt = "%-${col_width}s%-${col_width}s\n";

my $is_col1 = 1;
my ($in_block, $close_block) = (0, 0);
my (@col1, @col2);

while (<>) {
    chomp;

    my $is_record_sep = /\s*-+\s*$/;

    if ($is_record_sep) {
        $close_block = $in_block;
        $in_block = ! $in_block;
    }

    if ($in_block or $is_record_sep) { # (0 or 1) for closing separator
        if ($is_col1) {
            if (@col2) {
                printf $split_fmt, $_, shift @col2;
            }
            else {
                push @col1, $_; # save until we have col2 data to print
            }
        }
        elsif (@col1) {
            printf $split_fmt, shift @col1, $_;
        }
        else {
            push @col2, $_; # save until we have col1 data to print
        }

        if ($close_block) {
            if ($is_col1) { # add separation between blocks
                push @col1, '';
            }
            else {
                push @col2, '';
            }
            $is_col1 = ! $is_col1;
        }
    }
}

while (@col1 || @col2) {
    printf $split_fmt, shift @col1 // '', shift @col2 // '';
}
