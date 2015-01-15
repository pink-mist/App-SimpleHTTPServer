# App::SimpleHTTPServer

This contains a module and a small script that serves up a directory via http.

## serve\_me

The serve\_me script can be run by just typing "serve\_me" in the directory you
want to serve up. This will by default start up a http server on port 8000.

### Options

serve\_me understands the following options:

serve\_me [options] [port] [directory]

* [options] - Currently no options are supported, but a -h/--help option will
be added soon.

* [port] - Specify a port to open the http server on (default: 8000).

* [directory] - Specify a directory to serve (default: .).

If the directory you specify is just a number, you must also specify a port,
otherwise it will be interpreted as a port number. You can also specify such a
directory with an absolute path, or include the current directory when
specifying it as a relative path: ./[directory] instead of just [directory].

## App::SimpleHTTPServer

This is the module that makes things work under the hood, but you can also use
it directly: "perl -MApp::SimpleHTTPServer" which will do the same thing as
running "serve\_me" -- start up a http server on port 8000 serving the current
directory.

### Options

Just as with serve\_me, you can optionally specify a port and directory to
serve:
    perl -MApp::SimpleHTTPServer=8080
tells it to use port 8080, and:
    perl -MApp::SimpleHTTPServer=./foo
tells it to serve up the 'foo' directory. You can combine them both like so:
    perl -MApp::SimpleHTTPServer=8080,./foo
