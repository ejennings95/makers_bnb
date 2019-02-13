require 'pending_booking'

describe PendingBooking do
  let(:property_owner) { double(PropertyOwner.add(name: 'owner1', username: 'propowner100', email: 'owner1@gmail.com', password: '123'), id: PropertyOwner.list.first.id) }
  let(:property) { double(Properties.add(name: 'Jakes treehouse', description: '4 bedroom house', price: 90, location: '19 Nightingale rd, London, Greater London, UB7 9AQ, England', property_owner_id: property_owner.id, dates_booked: '2018-03-19'), id: Properties.list.first.id)}
  let(:user) {double(User.add( name: 'Jon Bob', username: 'jon21', email: 'jon@gmail.com', password: '135'), id: User.list.first.id)}

  it 'can create a new pending booking' do
    booking = PendingBooking.add(user_id: user.id, property_id: property.id, property_owner_id: property_owner.id, dates_booked: '2018-03-19', about_me: 'About me')
    expect(booking.dates_booked).to eq('2018-03-19')
  end

  it 'should be able to list all the pending bookings' do
    expect {PendingBooking.add(user_id: user.id, property_id: property.id, property_owner_id: property_owner.id, dates_booked: '2018-03-19', about_me: 'About me')}.to change { PendingBooking.list.count }.by 1
  end

  it 'should be able to remove a pending booking' do
    booking = PendingBooking.add(user_id: user.id, property_id: property.id, property_owner_id: property_owner.id, dates_booked: '2018-03-19', about_me: 'About me')
    PendingBooking.remove(id: PendingBooking.list.first.id)
    expect(PendingBooking.list.count).to eq 0
  end
end
