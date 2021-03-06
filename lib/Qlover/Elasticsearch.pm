package Qlover::Elasticsearch;
use strict;
use warnings;
use Search::Elasticsearch;
use Carp;
use Time::Piece;

our @NODES = $ENV{QLOVER_ES_NODES} ? split /,/, $ENV{QLOVER_ES_NODES} : ();
our $ES;

sub _es {
    my $class = shift;
    $ES ||= Search::Elasticsearch->new(nodes => [ ( $class->_nodes ) ]) or cloak($!);
    $ES;
}

sub _nodes {
    my $class = shift;
    if (scalar @NODES < 1) {
        @NODES = ('localhost:9200');
    }
    @NODES;
}

sub _parse_path {
    my ($class, $path) = @_;
    my ($index, $type) = $path =~ /^\/(.+?)\/(.+)$/;
    return ($index, $type);
}

sub add {
    my ($class, $path, $data) = @_;
    croak('Path and Data is required') unless $path && $data;

    my ($index, $type) = $class->_parse_path($path);
    croak('Path is not contains their type') unless $index && $type;

    my %data = (
        index => $index, 
        type  => $type, 
        body  => { %$data, timestamp => localtime->strftime('%Y-%m-%d %H:%M:%S') },
    );
    my $res = $class->_es->index( %data
    );
    $res;
}

1;
