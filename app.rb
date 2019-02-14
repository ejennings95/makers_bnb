require 'sinatra/base'
require 'sinatra/flash'
require_relative './spec/test_database'
require_relative './lib/database_setup'
require_relative './lib/properties'
require_relative './lib/property_owner'
require_relative './lib/user'
require_relative './lib/pending_booking'

class Makersbnb < Sinatra::Base
    enable :sessions
    register Sinatra::Flash

    get ('/') do
      erb(:index)
    end

    post ('/login') do
      @owner = params[:log_in_account]
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

    post ('/pending_bookings') do
      PendingBooking.add(user_id: params[:user_id], property_id: params[:property_id], property_owner_id: params[:property_owner_id], dates_booked: params[:check_in], about_me: params[:about_me])
      redirect '/browse/:id/confirmation'
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

    post ('/deleteproperty') do
      Properties.remove(id: params[:property_id])
      redirect '/myproperties'
    end

    post ('/add_property') do
      Properties.add(name: params[:name], description: params[:description], location: params[:location], price: params[:price], property_owner_id: params[:prop_owner_id])
      redirect ('/myproperties')
    end

    get ('/pendingapproval') do
      @pending_booking = PendingBooking.list
      @user_id = session[:user_id]
      @users = User.list
      @properties = Properties.list
      erb(:pending_approval)
    end

    post ('/bookingapproved') do
      Properties.add_booking_date(id: params[:property_id], dates_booked: params[:dates_booked])
      PendingBooking.remove(id: params[:pending_booking_id])
      redirect '/pendingapproval'
    end

    post ('/bookingdeclined') do
      PendingBooking.remove(id: params[:pending_booking_id])
      redirect '/pendingapproval'
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

    post ('/logout') do
      session.clear
      redirect ('/')
    end

  run! if app_file == $0
end
