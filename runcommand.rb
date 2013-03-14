#!/usr/local/bin/ruby

require 'rubygems'
require 'net/ssh'

hosts = "hosts.txt"
commands = "commands.txt"
user = 'username'

File.open(hosts).each_line{ |host|
  host = host.chomp
  ssh = Net::SSH.start(host, user)
 File.open(commands).each_line{ |command|
    command = command.chomp
    puts "Running #{command} on #{host}.\n"
    output = ssh.exec!(command)
    puts output
 }
}
