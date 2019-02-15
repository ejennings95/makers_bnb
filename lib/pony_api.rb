require 'pony'

class Mailer


  def sendemail
    Pony.mail({
      :to => 'elliot.r.jennings@outlook.com',
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
