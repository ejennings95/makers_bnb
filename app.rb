require 'sinatra/base'
require 'sinatra/flash'
require_relative './spec/test_database'
require_relative './lib/database_setup'
require_relative './lib/properties'
require_relative './lib/property_owner'
require_relative './lib/user'

class Makersbnb < Sinatra::Base
    enable :sessions
    register Sinatra::Flash

    get ('/') do
      erb(:index)
    end

    get ('/browse') do
        @owner= PropertyOwner.list.find { | user | user.id == session[:user_id] }
      if @owner == nil
        @user = User.list.find { | user | user.id == session[:user_id] }
      end
      @property_list = Properties.list
      erb(:property_list)
    end

    post'/view_property' do
      session[:property_id] = params[:property_id]
      redirect '/browse/:id'
    end

    get('/browse/:id') do
      @user_id = session[:user_id]
      @property = Properties.list.find { |property | property.id == session[:property_id]}
      p "@property"
      p @property
      erb(:property_details)
    end

    get ('/browse/:id/confirmation') do
      @user_id = session[:user_id]
      erb(:confirmation_pending)
    end

    get ('/ownerlogin') do
      erb(:log_in)
    end

    get ('/myproperties') do
      @property_list = Properties.list
    end

    get ('/signup') do
      erb(:sign_up)
    end

    post ('/signup') do
      p params[:account_type]
      if params[:account_type] = 'SIGN-UP TO ADVERTISE'
        PropertyOwner.add(name: params[:name], username: params[:username], email: params[:email], password: params[:password])
      else
        User.add(name: params[:name], username: params[:username], email: params[:email], password: params[:password])
      end
      redirect '/browse'
    end

  run! if app_file == $0
end
