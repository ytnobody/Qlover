package Qlover::Worker;
use strict;
use warnings;
use Linux::Inotify2;
use Qlover::Job;
use Qlover::BQ;
use Qlover::Elasticsearch;
use Log::Minimal;

sub run {
    my ($class, %opts) = @_;
    $opts{'--without-inotify'} ? 
        $class->_run_without_inotify(%opts) :
        $class->_run(%opts)
    ;
}

sub _run {
    my ($class, %opts) = @_;

    my @events;
    my $inotify = Linux::Inotify2->new or die $!;
    my $job_dir = $Qlover::Job::JOB_PATH;
    my $job_prefix = $Qlover::Job::JOB_PREFIX;
    my $job;

    $inotify->watch($job_dir, IN_CLOSE_WRITE) or die $!;

    infof 'Watching %s in pid %s', $job_dir, $$;
    while (1) {
        sleep 1;
        @events = grep {$_->name =~ /^$job_prefix/} ( $inotify->read );
        next unless @events;

        for my $event (@events) {
            my $jobfile = $event->name;
            $job = eval { Qlover::Job->fetch($jobfile) };
            if ($@) {
                warn $@;
                next;
            }
            $class->task($job);
        }
    }
}

sub _run_without_inotify {
    my ($class, %opts) = @_;

    my @events;
    my $job_dir = $Qlover::Job::JOB_PATH;
    my $job_prefix = $Qlover::Job::JOB_PREFIX;
    my $job;

    infof 'Without Inotify';
    infof 'Watching %s in pid %s', $job_dir, $$;
    while (1) {
        sleep 1;
        @events = map {$_ =~ s/^$job_dir\///; $_;} glob "$job_dir/$job_prefix*";
        next unless @events;

        for my $jobfile (@events) {
            $job = eval { Qlover::Job->fetch($jobfile) };
            if ($@) {
                warn $@;
                next;
            }
            $class->task($job);
        }
    }
}

sub task {
    my ($class, $job) = @_;

    infof 'QUERY:%s --> %s', $job->{path}, $job->{query};
    my $result = eval { Qlover::BQ->query($job->{query}) };
    if ($@) {
        warnf $@;
        return ;
    }
    if ($result) {
        infof 'RESULT: %d', scalar @$result;
    }
    else {
        infof 'RESULT: 0';
    }

    for my $entry (@$result) {
        Qlover::Elasticsearch->add($job->{path}, $entry);
    }
}


1;
