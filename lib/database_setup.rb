require_relative './database_connection'

if ENV['ENVIRONMENT'] == 'test'
  Database.setup('makersbnb_test')
else
  Database.setup('makersbnb')
end
