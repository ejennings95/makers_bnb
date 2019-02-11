class Properties

  attr_reader :id, :name, :description, :price, :location, :property_owner_id, :dates_booked

def initialize(id:, name:, description:, price:, location:, property_owner_id:, dates_booked:)
  @id = id
  @name = name
  @description = description
  @price = price
  @location = location
  @property_owner_id = property_owner_id
  @dates_booked = dates_booked
end

def self.add(name:, description:, price:, location:, property_owner_id:, dates_booked:)
  result = Database.query( "INSERT INTO properties(name, description, price, location, property_owner_id, dates_booked) VALUES('#{name}','#{description}', '#{price}', '#{location}', '#{property_owner_id}', '#{dates_booked}') RETURNING name, description, price, location, property_owner_id, dates_booked;")
  Properties.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], location: result[0]['location'], property_owner_id: result[0]['property_owner_id'], dates_booked: result[0]['dates_booked'])
end

end
