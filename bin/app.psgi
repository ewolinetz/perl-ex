#!/usr/bin/env perl
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Dancer2;
use inventory;

#config->{plugins}->{Database}->{database}=$ENV{'MYSQL_DATABASE'};
#config->{plugins}->{Database}->{host}=$ENV{'DATABASE_SERVICE_HOST'};
#config->{plugins}->{Database}->{port}=$ENV{'DATABASE_SERVICE_PORT'};
#config->{plugins}->{Database}->{username}=$ENV{'MYSQL_USER'};
#config->{plugins}->{Database}->{password}=$ENV{'MYSQL_PASSWORD'};
#Dancer2::Config::load();

inventory->to_app;
start;
