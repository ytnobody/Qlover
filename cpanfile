requires 'perl', '5.008001';
requires 'Carp';
requires 'File::Temp';
requires 'Guard';
requires 'JSON';
requires 'Search::Elasticsearch';
requires 'Plack::Handler::Starlet';
requires 'Server::Starter';
requires 'Linux::Inotify2';
requires 'Time::Piece';
requires 'Log::Minimal';

on 'test' => sub {
    requires 'HTTP::Request::Common';
    requires 'Test::More', '0.98';
};

