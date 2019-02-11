require_relative './database_connection'

if ENV['ENVIRONMENT'] == 'test'
  Database.setup('Makersbnb_test')
else
  Database.setup('Makersbnb')
end
