package Qlover::Job;
use strict;
use warnings;

use File::Temp qw/tempfile/;
use Qlover::JSON;
use Guard;
use Carp;

our $JOB_PATH = '/tmp';
our $JOB_PREFIX = 'qlover';

sub create {
    my ($class, %opts) = @_;
    my $job = Qlover::JSON->encode({%opts});

    my ($fh, $filename) = tempfile(TEMPLATE => $JOB_PREFIX.'XXXXX', DIR => $JOB_PATH);
    my ($jobname) = $filename =~ /^$JOB_PATH\/($JOB_PREFIX.+)$/;

    if ($fh) {
        print $fh $job;
        $fh->close;
        return {%opts, file => $jobname};
    }
}

sub fetch {
    my ($class, $jobname) = @_;
    return unless $jobname;
    return unless $jobname =~ /^$JOB_PREFIX/;
    my $file = "$JOB_PATH/$jobname";

    if (-f $file) {
        my $guard = guard {
            unlink $file;
        };

        open my $fh, '<', $file or croak("Could not fetch job :".$!);
        my $job_json = do { local $/; <$fh> };
        close $fh;
    
        return Qlover::JSON->decode($job_json);
    }
}

1;
