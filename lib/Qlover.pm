package Qlover;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

1;
__END__

=encoding utf-8

=head1 NAME

Qlover - Analyse with Google BigQuery. Then, Store these into Elasticsearch.

=head1 SYNOPSIS

Bootup the worker first.

    $ ./bin/qlover_worker.pl

Then, plackup the API server.

    $ plackup ./api.psgi

You can post a request with query for BigQuery. If you do so, qlover_worker.pl create docs into Elasticsearch automatically.

    $ curl -XPOST http://localhost:5000/yourindex/yourtype -F 'query=SELECT * FROM yourdataset.yourtable LIMIT 10;'

=head1 DESCRIPTION

Qlover is a transferring middleware BigQuery and Easticsearch.

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

