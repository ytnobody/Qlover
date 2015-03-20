#!/usr/bin/env perl

use strict;
use warnings;
use File::Spec;
use File::Basename 'dirname';
use lib ( File::Spec->catdir(dirname(__FILE__), qw/.. lib/) );
use Qlover::Worker;

Qlover::Worker->run;
