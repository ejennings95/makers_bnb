require 'sinatra/base'
require 'sinatra/flash'
require_relative './spec/test_database'
require_relative './lib/database_setup'

class Makersbnb < Sinatra::Base
    register Sinatra::Flash

  run! if app_file == $0
end
