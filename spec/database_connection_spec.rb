require 'database_connection'

describe Database do
  it 'should be able to set up a database' do
    expect(PG).to receive(:connect).with(dbname: 'Makersbnb_test')
    Database.setup('Makersbnb_test')
  end

  it 'this connection is saved' do
    connection = Database.setup('Makersbnb_test')
    expect(Database.connection).to eq connection
  end
end
