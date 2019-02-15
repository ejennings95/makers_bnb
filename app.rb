require 'sinatra/base'
require 'sinatra/flash'
require_relative './spec/test_database'
require_relative './lib/database_setup'
require_relative './lib/properties'
require_relative './lib/property_owner'
require_relative './lib/user'
require_relative './lib/pending_booking'
require_relative './lib/booking'
require_relative './lib/pony_api'
require 'pony'
require 'date'

class Makersbnb < Sinatra::Base
    enable :sessions
    register Sinatra::Flash

    get ('/') do
      erb(:index)
    end

    post ('/login') do
      session[:account_type] = params[:log_in_account]
      @account_type = session[:account_type]
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
      @account_type = session[:account_type]
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
      # @picture_one = properties.images
      # @picture_two = "http://i67.tinypic.com/1zzrmev.jpg"
      # @picture_three = "http://i68.tinypic.com/2cfxngm.jpg"
      @account_type = session[:account_type]
      @property_id = session[:property_id]
      @property_list = Properties.list
      @user_id = session[:user_id]
      @property = Properties.list.find { |property | property.id == session[:property_id]}
      @bookings = Booking.list
      erb(:property_details)
    end

    post ('/pending_bookings') do
      @bookings = Booking.list
      @bookings.each do | booking |
        if booking.property_id == params[:property_id]
        conflict = ( Date.parse(booking.start_date) <= Date.parse(params[:check_out]) && (Date.parse(params[:check_in]) <= (Date.parse(booking.end_date))) )
          if conflict == true
            flash[:notice] = "Dates already booked - try another date."
            redirect '/browse/:id'
          else
            PendingBooking.add(user_id: params[:user_id], property_id: params[:property_id], property_owner_id: params[:property_owner_id], start_date: params[:check_in], end_date: params[:check_out], about_me: params[:about_me], images: params[:images])
            redirect '/browse/:id/confirmation'
          end
        end
      end
    end

    get ('/browse/:id/confirmation') do
      @user_id = session[:user_id]
      erb(:confirmation_pending)
    end

    get ('/mybookings') do
      @account_type = session[:account_type]
      @user_id = session[:user_id]
      @properties = Properties.list
      @property_owner = PropertyOwner.list
      @bookings = Booking.list
      erb(:mybookings)
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
      @bookings = Booking.list
      @bookings.each do | booking |
        p "booking"
        p booking.property_id
        p params[:property_id]
        if booking.property_id == params[:property_id]
          flash[:notice] = "Cannot delete - there is a booking linked to this property."
          redirect '/myproperties'
          return
        else
        @pending_booking = PendingBooking.list
        @pending_booking.each do | pb |
          p "pending"
          p pb.property_id
          p pb[:property_id]
          if pb.property_id == params[:property_id]
            flash[:notice] = "Cannot delete - there is a pending booking linked to this property."
            redirect '/myproperties'
            return
          else
            Properties.remove(id: params[:property_id])
            redirect '/myproperties'
        end
      end
    end
  end
end

    post ('/add_property') do
      Properties.add(name: params[:name], description: params[:description], location: params[:location], price: params[:price], property_owner_id: params[:prop_owner_id], images: params[:images], second: params[:second], third: params[:third])
      redirect ('/myproperties')
    end

    get ('/pendingapproval') do
      @pending_booking = PendingBooking.list
      @user_id = session[:user_id]
      @users = User.list
      @properties = Properties.list
      @bookings = Booking.list
      erb(:pending_approval)
    end

    post ('/bookingapproved') do
      Booking.add(user_id: params[:user_id], property_id: params[:property_id], property_owner_id: params[:property_owner_id], start_date: params[:check_in], end_date: params[:check_out], about_me: params[:about_me], images: params[:images])
      @users = User.list
      @users.each do |user|
        if user.id == params[:user_id]
          email = Mailer.new
          email.emailsender(user.email)
        end
        PendingBooking.remove(id: params[:pending_booking_id])
      end
      redirect '/pendingapproval'
    end

    post('/sendemail') do
    end

    post ('/bookingdeclined') do
      PendingBooking.remove(id: params[:pending_booking_id])
      redirect '/pendingapproval'
    end

    get ('/signup') do
      erb(:sign_up)
    end

    post ('/signup') do
    session[:account_type] = params[:account_type]
    @account_type = session[:account_type]
    if params[:account_type] == 'SIGN-UP TO ADVERTISE'
      user =  PropertyOwner.add(name: params[:name], username: params[:username], email: params[:email], password: params[:password])
      if user
        session[:user_id] = user.id
        redirect '/myproperties'
      else
        flash[:warning] = "Email address or username already in use - try another one."
        redirect '/signup'
      end
    end
      if params[:account_type] == 'SIGN-UP TO RENT'
        user = User.add(name: params[:name], username: params[:username], email: params[:email], password: params[:password])
        if user
          session[:user_id] = user.id
          redirect '/browse'
        else
          flash[:warning] = "Email address or username already in use - try another one."
          redirect '/signup'
        end
      end
    end

    post ('/logout') do
      session.clear
      redirect ('/')
    end

  run! if app_file == $0
end
