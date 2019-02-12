require 'bcrypt'

class PropertyOwner
  attr_reader :id, :name, :username, :email, :password

  def initialize(id:, name:, username:, email:, password:)
    @id = id
    @name = name
    @username = username
    @email = email
    @password = password
  end

  def self.list
  Database.query( "SELECT * FROM property_owner" ).map do | row |
    PropertyOwner.new(id: row['id'], name: row['name'], username: row['username'], email: row['email'], password: row['password'])
  end
end

  def self.add(name:, username:, email:, password:)
    if (Database.query("SELECT * FROM property_owner WHERE email = '#{email}'") || Database.query("SELECT * FROM property_owner WHERE username = '#{username}'")).any?
      return
    else
      encrypted_password = BCrypt::Password.create(password)
      result = Database.query( "INSERT INTO property_owner(name, username, email, password) VALUES('#{name}', '#{username}', '#{email}', '#{encrypted_password }') RETURNING id, name, username, email, password;")
      PropertyOwner.new(id: result[0]['id'], name: result[0]['name'], username: result[0]['username'], email: result[0]['email'], password: result[0]['password'])
    end
  end

  def self.login(email:, password:)
    result = Database.query( "SELECT * FROM property_owner WHERE email = '#{email}'")
    return unless result.any?
    return unless BCrypt::Password.new(result[0]['password']) == password
    PropertyOwner.new(id: result[0]['id'], name: result[0]['name'], username: result[0]['username'], email: result[0]['email'], password: result[0]['password'])
  end
end
