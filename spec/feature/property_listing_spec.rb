  feature 'expect there to be a view property button' do
    scenario do
      visit '/browse'
      expect(page).to have_button('VIEW')
    end
  end

  feature 'expect there to be a home button' do
    scenario do
      visit '/browse'
      expect(page).to have_button('Home')
    end
  end

  feature 'expect there to be my properties button' do
    scenario do
      visit '/browse'
      expect(page).to have_button('MY PROPERTIES')
    end
  end
  #     within('li', text: 'The Jake Treehouse') do
  #     should have_content 'The Jake Treehouse'
  #   end
  # end
# expect(page).to have_xpath("//li[.='The Jake Treehouse']/..", text: 'The Jake Treehouse')
# end
