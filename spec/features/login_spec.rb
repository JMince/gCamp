require 'rails_helper'

  feature 'Users' do


    before do
      sign_in
    end

    scenario 'logged in users can see project, tasks, and users' do

      expect(current_path).to eq '/'
      click_on 'Projects'
      expect(page).to have_content('Projects')
      click_on 'Tasks'
      expect(page).to have_content('Tasks')
      click_on 'Users'
      expect(page).to have_content('Users')
    end


    scenario 'Users can signout' do
      visit root_path
      click_on 'Sign out'
      expect(page).to have_content('You have successfully logged out')
      expect(page).to have_content('Sign In')
      expect(page).to have_no_content('Sign out')
      expect(current_path).to eq '/'
    end

    scenario 'Users can sign in with valid credentials' do
      expect(page).to have_content("You have successfully signed in")
      expect(page).to have_content("First Last")
      expect(current_path).to eq '/'
    end



  end
