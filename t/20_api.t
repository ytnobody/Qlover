use strict;
use Test::More;
use HTTP::Request::Common;
use Plack::Test;
use Plack::Util;
use Qlover::API;
use Qlover::Job;
use JSON;
use t::Util;

my $JSON = JSON->new->utf8(1);
my $app = Qlover::API->run;
my $test = Plack::Test->create($app);

subtest 'norm_req' => sub {
    my $res = $test->request(GET '/');
    is $res->code, 404;
};

subtest 'post_query' => sub {
    my $query = 'SELECT * FROM mydataset.mytable LIMIT 10;';
    my $res = $test->request(POST '/foo/bar', [query => $query]);
    is $res->code, '200';
    my $res_json = $JSON->decode($res->content);
    is $res_json->{job}{query}, $query;

    my $job = Qlover::Job->fetch($res_json->{job}{file});
    is $job->{query}, $res_json->{job}{query};
    is $job->{path}, $res_json->{job}{path};
};

done_testing;
