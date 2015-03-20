use strict;
use Test::More;
use Qlover::Worker;

subtest 'task' => sub {
    my $job = { 
        path => '/web/cnt',
        query => 'select path, count(*) as cnt from [blog.access_log] where time >= "2015-03-01 00:00:00" and path like "%.html" group by path order by cnt desc limit 10;',
    };
    eval { Qlover::Worker->task($job) };
    ok ! $@, $@;
};

done_testing;
