class Properties

  attr_reader :id, :name, :description, :price, :location, :property_owner_id

def initialize(id:, name:, description:, price:, location:, property_owner_id:)
  @id = id
  @name = name
  @description = description
  @price = price
  @location = location
  @property_owner_id = property_owner_id
end

def self.add(name:, description:, price:, location:, property_owner_id:)
  result = Database.query( "INSERT INTO properties(name, description, price, location, property_owner_id) VALUES('#{name}','#{description}', #{price}, '#{location}', #{property_owner_id}) RETURNING name, description, price, location, property_owner_id;")
  Properties.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], location: result[0]['location'], property_owner_id: result[0]['property_owner_id'])
end

def self.list
  Database.query( "SELECT * FROM properties" ).map do | row |
    Properties.new(id: row['id'], name: row['name'], description: row['description'], price: row['price'], location: row['location'], property_owner_id: row['property_owner_id'])
    end
  end
  #
  # def self.add_booking_date(id:, dates_booked:)
  #   Database.query( "UPDATE properties SET dates_booked = '#{dates_booked}' WHERE id = '#{id}';")
  # end

  def self.remove(id:)
    Database.query( "DELETE FROM properties WHERE id = '#{id}'" )
  end
end
