class Properties

  attr_reader :id, :name, :description, :price, :location, :property_owner_id, :images, :second, :third

def initialize(id:, name:, description:, price:, location:, property_owner_id:, images:, second:, third:)
  @id = id
  @name = name
  @description = description
  @price = price
  @location = location
  @property_owner_id = property_owner_id
  @images = images
  @second = second
  @third = third
end

def self.add(name:, description:, price:, location:, property_owner_id:, images:, second:, third:)
  result = Database.query( "INSERT INTO properties(name, description, price, location, property_owner_id, images, second, third) VALUES('#{name}','#{description}', #{price}, '#{location}', #{property_owner_id}, '#{images}', '#{second}', '#{third}') RETURNING name, description, price, location, property_owner_id, images, second, third;")
  Properties.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], location: result[0]['location'], property_owner_id: result[0]['property_owner_id'], images: result[0]['images'], second: result[0]['second'], third: result[0]['third'])
end

def self.list
  Database.query( "SELECT * FROM properties" ).map do | row |
    Properties.new(id: row['id'], name: row['name'], description: row['description'], price: row['price'], location: row['location'], property_owner_id: row['property_owner_id'], images: row['images'], second: row['second'], third: row['third'])
    end
  end

  def self.remove(id:)
    Database.query( "DELETE FROM properties WHERE id = '#{id}'" )
  end
end
