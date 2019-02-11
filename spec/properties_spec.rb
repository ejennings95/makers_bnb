require 'database_helper'
require 'properties'

describe Properties do
  let(:property_owner) { double(:property_owner) }

  it 'can be create a property and save its name' do
    property = Properties.add(name: 'name', description: 'description', price: 10, location: 'location', property_owner_id: 'property_owner_id')
    expect(property.name).to eq 'name'
  end

  it 'can be create a property and save its description' do
    property = Properties.add(name: 'name', description: 'description', price: 10, location: 'location', property_owner_id: 'property_owner_id')
    expect(property.description).to eq 'description'
  end

  it 'can be create a property and save its price' do
    property = Properties.add(name: 'name', description: 'description', price: 10, location: 'location', property_owner_id: 'property_owner_id')
    expect(property.price).to eq 10
  end

  it 'can be create a property and save its location' do
    property = Properties.add(name: 'name', description: 'description', price: 10, location: 'location', property_owner_id: 'property_owner_id')
    expect(property.location).to eq 'location'
  end
end
