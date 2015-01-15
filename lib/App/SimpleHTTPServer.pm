use strict;
use warnings;
package App::SimpleHTTPServer;

# ABSTRACT: Serve up a directory via http simply and easily

BEGIN { @ARGV = qw/ -m production /; }
use Mojolicious::Lite;
use Scalar::Util qw/ looks_like_number /;

our $TESTING = 0;

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

    my @args = (qw/ daemon -l /, "http://*:$port/");
       @args = (qw/ eval /) if $TESTING; # For testing, it needs something to
                                         # do so it doesn't display help message

    app->secrets([qw/ foo /]);
    app->start(@args);
}

1;
