use strict;
use Test::More;
use Qlover::Job;
use t::Util;

my $job;
my $file;

subtest 'create' => sub {
    my $query = 'SELECT * FROM mydataset.mytable LIMIT 10;';
    my $path = '/mydb/mytable';
    $job = Qlover::Job->create(query => $query, path => $path);
    isa_ok $job, 'HASH';
    is $job->{query}, $query;
    is $job->{path}, $path;
    ok $job->{file};
    $file = $job->{file};
};

subtest 'fetch' => sub {
    my $fetched = Qlover::Job->fetch($file);
    isa_ok $fetched, 'HASH';
    is $fetched->{query}, $job->{query};
    is $fetched->{path}, $job->{path};
    ok ! -f $job->{file};
};

subtest 'fetch_failure' => sub {
    my $fetched = Qlover::Job->fetch;
    ok ! defined $fetched;
};

done_testing;
