require 'rails_helper'

  feature 'Users' do


    before do
      @user1 = User.create(first_name: 'First', last_name: 'Last', email: 'email@mail.com', password: 'securepass', password_confirmation: 'securepass')
      sign_in(@user1)
    end

    scenario 'logged in users can see project, and users' do

      expect(current_path).to eq '/projects'
      click_on 'Projects'
      expect(page).to have_content('Projects')
      click_on 'Users'
      expect(page).to have_content('Users')
    end


    scenario 'Users can signout' do
      visit root_path
      click_on 'Sign Out'
      expect(page).to have_content('You have successfully logged out')
      expect(page).to have_content('Sign In')
      expect(page).to have_no_content('Sign Out')
      expect(current_path).to eq '/'
    end

    scenario 'Users can sign in with valid credentials' do
      expect(page).to have_content("You have successfully signed in")
      expect(page).to have_content("First Last")
      expect(current_path).to eq '/projects'
    end



  end
