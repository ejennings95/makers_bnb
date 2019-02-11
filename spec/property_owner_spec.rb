require 'property_owner'

describe PropertyOwner do
  it 'can be create a new property owner' do
    owner = PropertyOwner.add(name: 'owner1')
    expect(owner.name).to eq 'owner1'
  end


  it 'should be able to list all the property owners' do
    expect { PropertyOwner.add(name: 'name') }.to change { PropertyOwner.list.count }.by 1
  end
end
