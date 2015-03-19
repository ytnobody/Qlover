use strict;
use Test::More;
use Qlover::Elasticsearch;

subtest 'index' => sub {
    my $res = Qlover::Elasticsearch->index('/web/cnt', {path => '/foo/bar', cnt => 32});
    diag explain($res);
    ok 1;
};

done_testing;
