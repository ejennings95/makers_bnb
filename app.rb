require 'sinatra/base'
require 'sinatra/flash'
require_relative './spec/test_database'
require_relative './lib/database_setup'
require_relative './lib/properties'
require_relative './lib/property_owner'

class Makersbnb < Sinatra::Base
    enable :sessions
    register Sinatra::Flash


    get ('/') do
      erb(:index)
    end

    get ('/browse') do
      @property_list = Properties.list
      erb(:property_list)
    end

    post'/view_property' do
      session[:property_id] = params[:property_id]
      redirect '/browse/:id'
    end

    get('/browse/:id') do
      @property = Properties.list.find { |property | property.id == session[:property_id]}
      p "@property"
      p @property
      erb(:property_details)
    end

    get ('/browse/:id/confirmation') do
      erb(:confirmation_pending)
    end

    get ('/ownerlogin') do
      erb(:log_in)
    end

    get ('/myproperties') do
      @property_list = Properties.list
    end

  run! if app_file == $0
end
