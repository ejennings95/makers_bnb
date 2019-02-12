  feature 'expect homepage to have title of our webapp' do
    scenario do
      visit '/'
      expect(page).to have_content 'MAKERS BNB'
    end
  end

  feature 'expect homepage to have a email entry' do
    scenario do
      visit '/'
      expect(page).to have_content 'EMAIL:'
    end
  end

  feature 'expect homepage to have password entry' do
    scenario do
      visit '/'
      expect(page).to have_content 'PASSWORD:'
    end
  end

  feature 'have a login button' do
    scenario do
      visit '/'
      expect(page).to have_submit_button("LOGIN")
    end
    end

    feature 'have a guest button' do
      scenario do
        visit '/'
        expect(page).to have_submit_button("CONTINUE AS GUEST")
      end
    end

    feature 'you can login' do
      scenario 'you can enter details and redirect to listings' do
        visit '/'
        fill_in('EMAIL:', :with => 'test@testing.com')
        fill_in('PASSWORD:', :with => 'testing123')
        click_button('LOGIN')
      expect(page).to have_content('The Jake Treehouse')
      end
    end

    feature 'you can sign-up from homepage' do
      scenario 'click signup button' do
        visit '/'
        expect(page).to have_submit_button("SIGN-UP")
      end
    end
