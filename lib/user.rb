class User
  attr_reader :id, :name, :username, :email, :password

  def initialize(id:, name:, username:, email:, password:)
    @id = id
    @name = name
    @username = username
    @email = email
    @password = password
  end

  def self.list
  Database.query( "SELECT * FROM users" ).map do | row |
    User.new(id: row['id'], name: row['name'], username: row['username'], email: row['email'], password: row['password'])
  end
end

  def self.add(name:, username:, email:, password:)
    result = Database.query( "INSERT INTO users(name, username, email, password) VALUES('#{name}', '#{username}', '#{email}', '#{password}') RETURNING id, name, username, email, password;")
    User.new(id: result[0]['id'], name: result[0]['name'], username: result[0]['username'], email: result[0]['email'], password: result[0]['password'])
  end
end
