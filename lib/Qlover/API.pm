package Qlover::API;
use strict;
use warnings;

use Qlover::Request;
use Qlover::Response;
use Qlover::Job;
use Qlover::JSON;

sub run {
    sub {
        my ($env) = @_;
        my $req = Qlover::Request->new($env);

        return __PACKAGE__->res_error->finalize unless $req->method eq 'POST';

        my $path = $req->path;
        my $query = $req->param('query');
    
        my $job = Qlover::Job->create( path => $path, query => $query );
        my $res_json = Qlover::JSON->encode({ job => $job, status => 200, message => 'Recepted.' });
    
        my $res = Qlover::Response->new(200, ['Content-Type' => 'application/json'], [$res_json]);
        $res->finalize;
    };
}

sub res_error {
    my ($class, $code, $message) = @_; 
    $code ||= 404;
    $message ||= 'Not Found';
    return Qlover::Response->new($code, ['Content-Type' => 'application/json'], [$message]);
}

1;
