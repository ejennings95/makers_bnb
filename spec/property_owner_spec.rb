require 'property_owner'

describe PropertyOwner do
  it 'can be create a new property owner' do
    owner = PropertyOwner.add(name: 'owner1', username: 'propowner100', email: 'owner1@gmail.com', password: '123')
    expect(owner.name).to eq 'owner1'
  end

  it 'should be able to list all the property owners' do
    expect { PropertyOwner.add(name: 'owner1', username: 'propowner100', email: 'owner1@gmail.com', password: '123') }.to change { PropertyOwner.list.count }.by 1
  end
end
