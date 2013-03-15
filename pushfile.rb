#!/usr/local/bin/ruby

require 'rubygems'
require 'net/sftp'

username='username'
hosts = 'hosts.txt'
pushfiles = 'files.txt'

File.open(hosts).each_line{ |host|
    host = host.chomp
    sftp = Net::SFTP.start(host, username)
  File.open(pushfiles).each_line{ |pushfile|
    pushfile = pushfile.chomp
    puts "Pushing #{pushfile} to #{host}.\n"
    sftp.upload!(pushfile, pushfile)
  }
}
