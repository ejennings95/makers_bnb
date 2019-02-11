require 'pg'

def test_database
  conn = PG.connect(dbname: 'Makersbnb_test')
  # Clean the tables
  conn.exec("TRUNCATE ;")
  # insert table name after truncate
end
