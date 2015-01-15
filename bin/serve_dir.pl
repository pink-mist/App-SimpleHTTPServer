#!/usr/bin/env perl

my @args;
BEGIN { @args = @ARGV; }

use App::SimpleHTTPServer @args;

# Really, there's not much more to this...
