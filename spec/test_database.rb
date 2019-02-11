require 'pg'

def test_database
  conn = PG.connect(dbname: 'Makersbnb_test')
  # Clean the tables
  conn.exec("TRUNCATE property_owner, properties;")
  # insert table name after truncate
end
