package inventory;
use Dancer2 ':syntax';
use Dancer2 ':script';
use Template;
#use DBI;
#use DBD::mysql;
use Dancer2::Plugin::Database;

set template => 'template_toolkit';
set layout => undef;
set views => File::Spec->rel2abs('./views');

# This is not working...
#use 'routes.pl';

#sub get_connection{
  #my $dbh=database({ database => $ENV{'MYSQL_DATABASE'}, host => $ENV{'DATABASE_SERVICE_HOST'}, port => $ENV{'DATABASE_SERVICE_PORT'}, username => $ENV{'MYSQL_USER'}, password => $ENV{'MYSQL_PASSWORD'} });
#  my $dbh=database({ database => "sampledb", host => "172.30.139.179", port => 3306, username => "userVDC", password => "utDfQGBU" });
#  return $dbh;
#}

sub init_db{

#  my $dbh = $_;

  eval { database->do("DROP TABLE foo") };

  database->do("CREATE TABLE foo (id INTEGER not null auto_increment, name VARCHAR(20), email VARCHAR(30), PRIMARY KEY(id))");
  database->do("INSERT INTO foo (name, email) VALUES (" . database->quote("Eric") . ", " . database->quote("eric\@example.com") . ")");
};

get '/' => sub {

    #my $dbh = get_connection();

    eval { database->prepare("SELECT * FROM foo")->execute() };
    init_db(); # if $@;

    my $sth = database->prepare("SELECT * FROM foo");
    $sth->execute();

    my $data = $sth->fetchall_hashref('id');
    $sth->finish();

    my $timestamp = localtime();
    template index => {data => $data, timestamp => $timestamp};
    #template test => {timestamp => $timestamp, data => config->{plugins}->{Database}->{database}}; #$ENV{'MYSQL_DATABASE'}};

    #$dbh->disconnect();
};

post '/' => sub {

   my $name = params->{name};
   my $email = params->{email};

   #my $dbh = get_connection();
   
   database->do("INSERT INTO foo (name, email) VALUES (" . database->quote($name) . ", " . database->quote($email) . ") ");

   my $sth = database->prepare("SELECT * FROM foo");
   $sth->execute();

   my $data = $sth->fetchall_hashref('id');
   $sth->finish();

   my $timestamp = localtime();
   template index => {data => $data, timestamp => $timestamp};
};

true;
