# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
include SendGrid

# class Mailer
#   def confirmationemail
  from = Email.new(email: 'makersbnb@mail.com')
  to = Email.new(email: 'elliot.r.jennings@outlook.com')
  subject = 'MakersBnB - Booking Confirmation!'
  content = Content.new(type: 'text/plain', value: 'I am pleased to confirm that your booking has been confirmed. Please visit localhost:9292')
  mail = Mail.new(from, subject, to, content)

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body
  puts response.headers
#   end
# end
