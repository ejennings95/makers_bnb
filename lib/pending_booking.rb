require 'bcrypt'

class PendingBooking
  attr_reader :id, :user_id, :property_id, :property_owner_id, :dates_booked, :about_me

  def initialize(id:, user_id:, property_id:, property_owner_id:, dates_booked:, about_me:)
    @id = id
    @user_id = user_id
    @property_id = property_id
    @property_owner_id = property_owner_id
    @dates_booked = dates_booked
    @about_me = about_me
  end


  def self.list
    Database.query( "SELECT * FROM pending_bookings" ).map do | row |
      PendingBooking.new(id: row['id'], user_id: row['user_id'], property_id: row['property_id'], property_owner_id: row['property_owner_id'], dates_booked: row['dates_booked'], about_me: row['about_me'])
    end
  end

  def self.add(user_id:, property_id:, property_owner_id:, dates_booked:, about_me:)
    result = Database.query( "INSERT INTO pending_bookings(user_id, property_id, property_owner_id, dates_booked, about_me) VALUES('#{user_id}', '#{property_id}', '#{property_owner_id}', '#{dates_booked}', '#{about_me}') RETURNING id, user_id, property_id, property_owner_id, dates_booked, about_me;")
    PendingBooking.new(id: result[0]['id'], user_id: result[0]['user_id'], property_id: result[0]['property_id'], property_owner_id: result[0]['property_owner_id'], dates_booked: result[0]['dates_booked'], about_me: result[0]['about_me'])
  end


  def self.remove(id:)
    Database.query( "DELETE FROM pending_bookings WHERE id = '#{id}'" )
  end
end
