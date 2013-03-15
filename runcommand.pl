#!/usr/bin/perl
use warnings;
use strict;

use Net::OpenSSH;

open HOSTS,"hosts.txt";
my @hosts = <HOSTS>;
open COMMANDS,"commands.txt";
my @commands = <COMMANDS>;

for my $host (@hosts) {
  chomp ($host);
  my $ssh = Net::OpenSSH->new($host);
  $ssh->error and
    die "remote command failed: " . $ssh->error;
for my $command (@commands) {
  chomp ($command);
  print "Running $command on $host \n";
  $ssh->system($command) or
    die "remote command $command failed: " . $ssh->error;
  }
}
