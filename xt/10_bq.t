use strict;
use Test::More;
use Qlover::BQ;

subtest 'query' => sub {
    my $query = 'select path, count(*) as cnt from [blog.access_log] where time >= "2015-03-01 00:00:00" and path like "%.html" group by path order by cnt desc limit 10;';
    my $res = Qlover::BQ->query($query);
    isa_ok $res, 'ARRAY';
    isa_ok $res->[0], 'HASH';
};

done_testing;
