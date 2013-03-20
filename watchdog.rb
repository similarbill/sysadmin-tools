#!/usr/bin/ruby

require 'net/http'
require 'uri'
require 'net/smtp'
require 'socket'

check_url = "http://somedomain/someurl"
expect_content = "foo"
service_name = "your.service.name.here"
mailserver = "your.smtp.server"
from = "alertbot@example.com"
to = "alertlist@example.com"
message = "Subject: Service " + service_name + " on " + Socket.gethostname + " is down.  Restarting."

smtp = Net::SMTP.new mailserver, 25 
	
Net::HTTP.get_response(URI.parse(check_url)) do |response|
  response=response.body
  if response.include?(expect_content)
  else 
       system("service", service_name, "restart")
       smtp.send_message(message, from, to) 
       smtp.finish	
  end
end
