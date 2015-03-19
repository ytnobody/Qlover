package t::Util;
use strict;
use Guard;

our $CLEANUP = guard {
    for my $job ( glob '/tmp/qlover*' ) {
        unlink $job;
    }
};

1;
