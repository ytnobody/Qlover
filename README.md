# NAME

Qlover - Analyse with Google BigQuery. Then, Store these into Elasticsearch.

# SYNOPSIS

Bootup the worker first.

    $ ./bin/qlover_worker.pl

Then, plackup the API server.

    $ plackup ./api.psgi

You can post a request with query for BigQuery. If you do so, qlover\_worker.pl create docs into Elasticsearch automatically.

    $ curl -XPOST http://localhost:5000/yourindex/yourtype -F 'query=SELECT * FROM yourdataset.yourtable LIMIT 10;'

# DESCRIPTION

Qlover is a transferring middleware BigQuery and Easticsearch.

# LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

ytnobody <ytnobody@gmail.com>
