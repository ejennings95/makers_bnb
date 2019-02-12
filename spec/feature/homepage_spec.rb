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

    feature 'You can enter all details upon clicking sign-up button' do
      scenario 'you redirect to enter details' do
        visit '/'
        click_button('SIGN-UP')
        expect(page).to have content('SELECT TYPE OF ACCOUNT:')
      end
    end

    feature 'you can sign up and add yourself as a user' do
      scenario 'you can enter all your details as a user and sign up' do
        visit '/'
        click_button('SIGN-UP')
        fill_in('NAME', :with => 'test name')
        fill_in('USERNAME', :with => 'testingtesttest')
        fill_in('EMAIL ADDRESS:', :with => 'testemail@testing.com')
        fill_in('PASSWORD', :with => 'testytesttest')
        click_button('SUBMIT')
        expect(page).to have_contnent('The Jake Treehouse')
      end
    end 
