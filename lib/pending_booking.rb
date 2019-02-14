class PendingBooking
  attr_reader :id, :user_id, :property_id, :property_owner_id, :start_date, :end_date, :about_me

  def initialize(id:, user_id:, property_id:, property_owner_id:, start_date:, end_date:, about_me:)
    @id = id
    @user_id = user_id
    @property_id = property_id
    @property_owner_id = property_owner_id
    @start_date = start_date
    @end_date = end_date
    @about_me = about_me
  end


  def self.list
    Database.query( "SELECT * FROM pending_bookings" ).map do | row |
      PendingBooking.new(id: row['id'], user_id: row['user_id'], property_id: row['property_id'], property_owner_id: row['property_owner_id'], start_date: row['start_date'], end_date: row['end_date'], about_me: row['about_me'])
    end
  end

  def self.add(user_id:, property_id:, property_owner_id:, start_date:, end_date:, about_me:)
    result = Database.query( "INSERT INTO pending_bookings(user_id, property_id, property_owner_id, start_date, end_date, about_me) VALUES('#{user_id}', '#{property_id}', '#{property_owner_id}', '#{start_date}', '#{end_date}', '#{about_me}') RETURNING id, user_id, property_id, property_owner_id, start_date, end_date, about_me;")
    PendingBooking.new(id: result[0]['id'], user_id: result[0]['user_id'], property_id: result[0]['property_id'], property_owner_id: result[0]['property_owner_id'], start_date: result[0]['start_date'], end_date: result[0]['end_date'], about_me: result[0]['about_me'])
  end


  def self.remove(id:)
    Database.query( "DELETE FROM pending_bookings WHERE id = '#{id}'" )
  end
end
