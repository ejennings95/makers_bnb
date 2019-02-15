require 'pony'

class Mailer

  def emailsender(email)
    Pony.mail({
      :to => email,
      :via => :smtp,
      :via_options => {
        :address        => 'smtp.gmail.com',
        :port           => '25',
        :user_name      => 'bnbmakers@gmail.com',
        :password       => 'OpenAPI1',
        :authentication => :plain, # :plain, :login, :cram_md5, no auth by default
        :domain         => "localhost.localdomain" # the HELO domain provided by the client to the server
      }
      })
  end
end
