#!/usr/bin/perl
use warnings;
use strict;

use Net::SFTP::Foreign;

open SERVERLIST,"serverlist.txt";
my @servers =<SERVERLIST>;
open FILES,"files.txt";
my @files = <FILES>;

for my $server (@servers) {

  chomp ($server);
  my $sftp = Net::SFTP::Foreign->new($server);
  $sftp->die_on_error("unable to connect to $server");

    for my $file (@files) {
      chomp ($file);
      print "Pushing $file to $server \n";
      $sftp->put($file, $file) or die "put failed: " . $sftp->error;
    }
}
