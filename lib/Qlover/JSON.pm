package Qlover::JSON;
use strict;
use JSON;

our $JSON;

sub _json {
    $JSON ||= JSON->new->utf8(1);
}

sub encode {
    my ($class, $data) = @_;
    $class->_json->encode($data);
}

sub decode {
    my ($class, $data) = @_;
    $class->_json->decode($data);
}

1;
