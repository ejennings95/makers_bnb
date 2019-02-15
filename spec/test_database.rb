require 'pg'

def test_database
  conn = PG.connect(dbname: 'makersbnb_test')
  # Clean the tables
  conn.exec("TRUNCATE bookings, pending_bookings, property_owner, properties, users;")
  # insert table name after truncate
end
