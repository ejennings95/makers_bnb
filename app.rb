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

    post ('/login') do
      if params[:log_in_account] == 'ADVERTISE ACCOUNT'
        user = PropertyOwner.login(email: params[:email], password: params[:password])
        if user
          session[:user_id] = user.id
          redirect '/myproperties'
        else
          flash[:notice] = "Invaild email or password given - try again."
          redirect '/'
        end
      end
        if params[:log_in_account] == 'RENT ACCOUNT'
        user = User.login(email: params[:email], password: params[:password])
        if user
          session[:user_id] = user.id
          redirect '/browse'
        else
          flash[:notice] = "Invaild email or password given - try again."
          redirect '/'
        end
      end
    end

    get ('/browse') do
        @user= PropertyOwner.list.find { | user | user.id == session[:user_id] }
      if @user == nil
        @user = User.list.find { | user | user.id == session[:user_id] }
      end
      @property_list = Properties.list
      @user_id = session[:user_id]
      erb(:property_list)
    end

    post'/view_property' do
      session[:property_id] = params[:property_id]
      redirect '/browse/:id'
    end

    get('/browse/:id') do
      @user_id = session[:user_id]
      @property = Properties.list.find { |property | property.id == session[:property_id]}
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
      @user_id = session[:user_id]
      @property_list = Properties.list
      erb(:my_properties)
    end

    post ('/add_property') do
      add_property = Properties.add(name: params[:name], description: params[:description], location: params[:location], price: params[:price], property_owner_id: params[:property_owner_id])
    end

    get ('/signup') do
      erb(:sign_up)
    end

    post ('/signup') do
    if params[:account_type] == 'SIGN-UP TO ADVERTISE'
      user =  PropertyOwner.add(name: params[:name], username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = user.id
      redirect '/myproperties'
    else
      params[:account_type] == 'SIGN-UP TO RENT'
      user = User.add(name: params[:name], username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = user.id
      redirect '/browse'
    end
  end



      # owner =  PropertyOwner.add(name: params[:name], username: params[:username], email: params[:email], password: params[:password])
      # session[:user_id] = owner.id
    #   user = User.add(name: params[:name], username: params[:username], email: params[:email], password: params[:password])
    #   if user
    #     session[:user_id] = user.id
    #     redirect '/browse'
    #   else
    #     flash[:warning] = "Email already in use - please try another."
    #     redirect '/signup'
    #   end
    # end

    post ('/logout') do
      session.clear
      redirect ('/')
    end

  run! if app_file == $0
end
