require 'rails_helper'

  feature 'Invalid Users' do

    scenario 'Users cannot sign in with invalid credentials' do
      user1 = User.create(first_name: 'first', last_name: 'last', email: 'email@mail.com',
      password: 'securepass', password_confirmation: 'securepass')
      visit sign_in_path
      fill_in :email, with: 'email@mail.com'
      fill_in :password, with: "differentpassword"
      within("form") {click_on "Sign In"}
      expect(page).to have_content("Email / Password combination is invalid")
      expect(current_path).to eq '/sign-in'
    end

end
