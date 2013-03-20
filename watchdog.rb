#!/usr/bin/ruby

require 'net/http'
require "uri"
require 'net/smtp'

url = "http://somedomain/someurl"
restart = "service your.service.name.here restart"
mailserver = "your.smtp.server"
from = "alertbot@example.com"
to = "alertlist@example.com"
message = "Subject:  Service is down!"

smtp = Net::SMTP.new mailserver, 25 
	
Net::HTTP.get_response(URI.parse(url)) do |response|
  response=response.body
  if response.include?('foo')
  else 
       system(restart) 
       smtp.send_message(message, from, to) 
       smtp.finish	
  end
end
