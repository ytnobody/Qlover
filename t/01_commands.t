use strict;
use Test::More;

subtest 'gcloud' => sub {
    my $rescode = eval { system('gcloud version') };
    is $rescode, 0, 'CHECK "Google Cloud SDK" IS INSTALLED!!!!';
};

done_testing;
