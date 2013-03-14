#!/usr/bin/env python

import paramiko
from paramiko import AutoAddPolicy, SSHClient

port = 22
username = 'username'
pkey_file = '/home/username/.ssh/id_rsa'
hosts = 'hosts.txt'
commands = 'commands.txt'

key = paramiko.RSAKey.from_private_key_file(pkey_file)
paramiko.util.log_to_file('paramiko.log')
client = paramiko.SSHClient()
client.set_missing_host_key_policy(AutoAddPolicy())
client.load_system_host_keys()

for host in open(hosts):
    host=host.rstrip()
    client.connect(host, port, username, pkey=key)
    for command in open(commands):
      command=command.rstrip()
      print "Running",command,"on",host
      stdin, stdout, stderr = client.exec_command(command)
      print stdout.read()
    client.close()
