class PropertyOwner
  attr_reader :id, :name

  def initialize(id:, name:)
    @id = id
    @name = name
  end

  def self.list
  Database.query( "SELECT * FROM property_owner" ).map do | row |
    PropertyOwner.new(id: row['id'], name: row['name'])
  end
end

  def self.add(name:)
    result = Database.query( "INSERT INTO property_owner(name) VALUES('#{name}') RETURNING id, name;")
    PropertyOwner.new(id: result[0]['id'], name: result[0]['name'])
  end
end
