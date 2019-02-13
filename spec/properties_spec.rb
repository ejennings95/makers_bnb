require 'properties'

describe Properties do
  let(:property_owner) { double(PropertyOwner.add(name: 'owner1', username: 'propowner100', email: 'owner1@gmail.com', password: '123'), id: PropertyOwner.list.first.id) }

  it 'can be create a property and save its name' do
    property = Properties.add(name: 'name', description: 'description', price: 10, location: 'location', property_owner_id: property_owner.id)
    expect(property.name).to eq 'name'
  end

  it 'can be create a property and save its description' do
    property = Properties.add(name: 'name', description: 'description', price: 10, location: 'location', property_owner_id: property_owner.id)
    expect(property.description).to eq 'description'
  end

  it 'can be create a property and save its price' do
    property = Properties.add(name: 'name', description: 'description', price: 10, location: 'location', property_owner_id: property_owner.id)
    expect(property.price).to eq 10.to_s
  end

  it 'can be create a property and save its location' do
    property = Properties.add(name: 'name', description: 'description', price: 10, location: 'location', property_owner_id: property_owner.id)
    expect(property.location).to eq 'location'
  end

  # it 'can be create a property and save its unavailble dates' do
  #   property = Properties.add(name: 'name', description: 'description', price: 10, location: 'location', property_owner_id: property_owner.id, dates_booked: '2018-04-15')
  #   expect(property.dates_booked).to eq '2018-04-15'
  # end

  it 'should be able to list all the properties' do
    expect { Properties.add(name: 'name', description: 'description', price: 10, location: 'location', property_owner_id: property_owner.id) }.to change { Properties.list.count }.by 1
  end
end
