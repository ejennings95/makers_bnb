require 'property_owner'

describe PropertyOwner do
  it 'can be create a new property owner' do
    owner = PropertyOwner.add(name: 'owner1')
    expect(owner.name).to eq 'owner1'
  end
end
