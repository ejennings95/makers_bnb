require 'user'

describe User do
  it 'can be create a new user' do
    user = User.add(name: 'user1', username: 'user100', email: 'user1@gmail.com', password: '123')
    expect(user.name).to eq 'user1'
  end


  it 'should be able to list all the user' do
    expect { User.add(name: 'user1', username: 'user100', email: 'user1@gmail.com', password: '123') }.to change { User.list.count }.by 1
  end
end
