package Qlover::BQ;
use strict;
use warnings;
use Qlover::JSON;
use Carp;

sub query {
    my ($class, $query) = @_;
    my $res = eval { `bq query --format json -q '$query'` };
    croak($@) if $@;
    return Qlover::JSON->decode($res);
}

1;
