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

    push @{ app->renderer->classes }, __PACKAGE__;
    push @{ app->static->classes }, __PACKAGE__;

    plugin 'Directory::Stylish' => root => $path;

    my @args = (qw/ daemon -l /, "http://*:$port/");
       @args = (qw/ eval /) if $TESTING; # For testing, it needs something to
                                         # do so it doesn't display help message

    app->secrets([qw/ foo /]);
    app->start(@args);
}

1;

=head1 SYNOPSIS

  $ # To serve the current directory via http on port 8000, simply do:
  $ perl -MApp::SimpleHTTPServer

  $ # or use the serve_dir script:
  $ serve_dir

=head1 SEE ALSO

L<serve_dir> - The script used to run this module.

L<Mojolicious> - The Mojolicious web framework

L<Mojolicious::Plugin::Directory::Stylish> - The module that actually renders
the directory listing

=cut

__DATA__
