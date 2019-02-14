# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
include SendGrid
require 'pg'

#notes for moring need to find a way to iterate over this command to include the email details from both
#user & property owner.

def booking_confirmation
  from = Email.new(email: 'test@example.com')
  subject = 'Booking Confirmation - MakersBnB(TBC)'
  to = Email.new(email: 'test@example.com')
  content = Content.new(type: 'text/plain', value: 'I am pleased to confirm your booking. To see the details please go to localhost:9292')
  mail = SendGrid::Mail.new(from, subject, to, content)
  # puts JSON.pretty_generate(mail.to_json)
  puts mail.to_json

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], host: 'https://api.sendgrid.com')
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body
  puts response.headers
end
