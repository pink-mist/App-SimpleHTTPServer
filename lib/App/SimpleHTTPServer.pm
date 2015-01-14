use strict;
use warnings;
package App::SimpleHTTPServer;

# ABSTRACT: Serve up a directory via http simply and easily
use Mojolicious::Lite;
use Scalar::Util qw/ looks_like_number /;

sub import {
    my $package = shift;
    my $port    = shift;
    if (not looks_like_number $port) {
        unshift @_, $port if defined $port;
        $port   = 8000;
    }
    my $path    = shift;
       $path    = '.' unless defined $path;

    plugin Directory => root => $path;

    app->start( qw/ daemon -m production -l /, "http://*:$port/" );
}

1;
