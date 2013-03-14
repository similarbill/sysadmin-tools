#!/usr/bin/env python

import paramiko
from paramiko import AutoAddPolicy, SSHClient

port = 22
username = 'username'
pkey_file = '/home/username/.ssh/id_rsa'
hosts = 'hosts.txt'
files = 'files.txt'

key = paramiko.RSAKey.from_private_key_file(pkey_file)
paramiko.util.log_to_file('paramiko.log')

for host in open(hosts):
    host=host.rstrip()
    client = paramiko.Transport((host, port))
    client.connect(username=username, pkey=key)
    sftp = paramiko.SFTPClient.from_transport(client)
    for file in open(files):
      file=file.rstrip()
      print "Pushing",file,"to",host
      sftp.put(file, file)
    client.close()
