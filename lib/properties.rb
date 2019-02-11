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
  result = Database.query( "INSERT INTO properties(name, description, price, location, property_owner_id) VALUES('#{name}','#{description}', '#{price}', '#{location}', '#{property_owner_id}') RETURNING name, description, price, location, property_owner_id;")
  Properties.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], location: result[0]['location'], property_owner_id: result[0]['property_owner_id'])
end

end
