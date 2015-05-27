#!/usr/bin/perl

use Dancer ':syntax';

prefix '/test';

get '/' => sub {
    return [ 200, [ 'Content-Type' => 'text/plain' ], [ 'Hello again!' ] ];
};
