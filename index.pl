#!/usr/bin/env perl
use Dancer2;
use Plack::Runner;

## For some reason Apache SetEnv directives dont propagate
## correctly to the dispatchers, so forcing PSGI and env here 
## is safer.
set apphandler => 'PSGI';
set environment => 'production';

#set plugins => [ 'Database' => [ 'database' => [ $ENV{'MYSQL_DATABASE'} ] ], 
#                               [ 'host' => [ $ENV{'DATABASE_SERVICE_HOST'} ] ], 
#                               [ 'port' => [ $ENV{'DATABASE_SERVICE_PORT'} ] ], 
#                               [ 'username' => [ $ENV{'MYSQL_USER'} ] ],
#                               [ 'password' => [ $ENV{'MYSQL_PASSWORD'} ] ] ];
#config->{plugins}->{Database}->{database}=$ENV{'MYSQL_DATABASE'};
#config->{plugins}->{Database}->{host}=$ENV{'DATABASE_SERVICE_HOST'};
#config->{plugins}->{Database}->{port}=$ENV{'DATABASE_SERVICE_PORT'};
#config->{plugins}->{Database}->{username}=$ENV{'MYSQL_USER'};
#config->{plugins}->{Database}->{password}=$ENV{'MYSQL_PASSWORD'};
#Dancer2::Config->load();

my $psgi;
$psgi = path($ENV{'DOCUMENT_ROOT'}, 'bin', 'app.psgi');
die "Unable to read startup script: $psgi" unless -r $psgi;

Plack::Runner->run($psgi);
