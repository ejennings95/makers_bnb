require 'properties'

describe Properties do
  let(:property_owner) { double(PropertyOwner.add(name: 'name'), id: PropertyOwner.list.first.id) }

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
end
