require 'database_connection'

describe Database do
  it 'should be able to set up a database' do
    expect(PG).to receive(:connect).with(dbname: 'makersbnb_test')
    Database.setup('makersbnb_test')
  end

  it 'this connection is saved' do
    connection = Database.setup('makersbnb_test')
    expect(Database.connection).to eq connection
  end
end

describe 'query' do
  it 'should exectue a query' do
    connection = Database.setup('makersbnb_test')
    expect(connection).to receive(:exec).with("SELECT * FROM properties;")
    Database.query("SELECT * FROM properties;")
  end
end
