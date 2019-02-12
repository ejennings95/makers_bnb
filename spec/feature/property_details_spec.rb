feature 'expects to show the property in more detail' do
  scenario 'shows further information' do
    visit '/browse/:id'
    expect(page).to have_content ('The Jake Treehouse')
    end
  end

feature 'expects to show the property in more detail' do
  scenario 'shows further information' do
    visit '/browse/:id'
    expect(page).to have_content ('Price')
  end
end
