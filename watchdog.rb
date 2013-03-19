require 'net/http'
require "uri"
require 'net/smtp'

url = "http://somedomain/someurl"
restart = "service your.service.name.here restart"
mailserver = "your.smtp.server"
maillogin = "your.alert.user.login"
mailpassword = "your.alert.user.password"
maildomain = "your.domain"
from = "alertbot@example.com"
to = "alertlist@example.com"
message = "Subject:  Service is down!"

smtp = Net::SMTP.new 'smtp.yourserver.com', 587
smtp.enable_starttls
	
Net::HTTP.get_response(URI.parse(url)) do |response|
  response=response.body
  if response.include?('foo')
  else 
       system(restart) 
       smtp.start(maildomain, maillogin, mailpassword, :login) do
         smtp.send_message(message, from, to) 
  end
       end
end
