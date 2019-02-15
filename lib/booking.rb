class Booking
  attr_reader :id, :user_id, :property_id, :property_owner_id, :start_date, :end_date, :about_me, :images

  def initialize(id:, user_id:, property_id:, property_owner_id:, start_date:, end_date:, about_me:, images:)
    @id = id
    @user_id = user_id
    @property_id = property_id
    @property_owner_id = property_owner_id
    @start_date = start_date
    @end_date = end_date
    @about_me = about_me
    @images = images
  end

  def self.list
    Database.query( "SELECT * FROM bookings" ).map do | row |
      Booking.new(id: row['id'], user_id: row['user_id'], property_id: row['property_id'], property_owner_id: row['property_owner_id'], start_date: row['start_date'], end_date: row['end_date'], about_me: row['about_me'], images: row['images'])
    end
  end

  def self.add(user_id:, property_id:, property_owner_id:, start_date:, end_date:, about_me:, images:)
    result = Database.query( "INSERT INTO bookings(user_id, property_id, property_owner_id, start_date, end_date, about_me, images) VALUES('#{user_id}', '#{property_id}', '#{property_owner_id}', '#{start_date}', '#{end_date}', '#{about_me}', '#{images}') RETURNING id, user_id, property_id, property_owner_id, start_date, end_date, about_me, images;")
    Booking.new(id: result[0]['id'], user_id: result[0]['user_id'], property_id: result[0]['property_id'], property_owner_id: result[0]['property_owner_id'], start_date: result[0]['start_date'], end_date: result[0]['end_date'], about_me: result[0]['about_me'], images: result[0]['images'])
  end


  def self.remove(id:)
    Database.query( "DELETE FROM bookings WHERE id = '#{id}'" )
  end

#   def self.booked?(property_id:, start_date:, end_date:)
#     Database.query( "SELECT property_id FROM bookings WHERE ('2019-06-25', '2019-06-28') OVERLAPS ('#{start_date}', '#{end_date}') RETURNING property_id;" )
# end
end
