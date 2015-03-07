require 'rails_helper'

feature 'Sign Up' do

  scenario 'user can sign up with flash message' do
    visit root_path
    click_on 'Sign Up'
    expect(page).to have_content("Sign up for gCamp!")
    fill_in :user_first_name, with: 'first1'
    fill_in :user_last_name, with: 'last1'
    fill_in :user_email, with: 'email1@email1.com'
    fill_in :user_password, with: 'securepass1'
    fill_in :user_password_confirmation, with: 'securepass1'
    within("form") {click_on 'Sign Up'}
    expect(current_path).to eq '/'
    expect(page).to have_content("You have successfully signed up")
    expect(page).to have_content('first1 last1')
    expect(page).to have_no_content( 'Sign Up')
  end

end
