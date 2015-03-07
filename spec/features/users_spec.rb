require 'rails_helper'

feature 'Users' do

  before :each do
    @user = User.create!(
      first_name: 'George',
      last_name: 'Jetson',
      email: 'george@jetson.com',
      password: 'cool jets',
      password_confirmation: 'cool jets')
    sign_in(@user)
    @user1 = User.create!(
      first_name: 'joe',
      last_name: 'shmoe',
      email: 'joe@jetson.com',
      password: 'jets',
      password_confirmation: 'jets')
  end

  scenario 'Test sign-in form' do
    visit signin_path
  end


  scenario 'User can see users index page' do
    visit users_path
    expect(page).to have_content('Users')
    expect(page).to have_content('George Jetson')
  end

  scenario 'New user can be added' do
    visit root_path
    click_on 'Sign Out'
    click_on 'Sign Up'
    fill_in 'First name', with: 'Artemus'
    fill_in 'Last name', with: 'Pyle'
    fill_in 'Email', with: 'arty@pyle.com'
    fill_in 'Password', with: 'art'
    fill_in 'Password confirmation', with: 'art'
    within('form') do
      click_on 'Sign Up'
    end

    expect(page).to have_content('You have successfully signed up')
    expect(page).to have_content('Artemus Pyle')

  end


  scenario 'User can see user show page' do
    visit root_path
    click_on 'Users'
    click_on 'joe shmoe'

    expect(page).to have_content('joe shmoe')
    expect(page).to have_content('Edit')

  end


  # scenario 'Users can update a User' do
  #   visit root_path
  #   click_on 'Users'
  #     within('body')do
  #     click_on 'George Jetson'
  #     end
  #   click_on 'Edit'
  #   fill_in 'Last name', with:'Stetson'
  #   click_on 'Update User'
  #
  #   expect(page).to have_content('User was successfully updated')
  #   expect(page).to have_no_content('Jetson')
  #
  # end
  #
  # scenario 'User can delete users' do
  #   visit root_path
  #   click_on 'Users'
  #   click_on 'George Jetson'
  #   click_on 'Edit'
  #   click_on 'Delete'
  #
  #   expect(page).to have_no_content('George Jetson')
  #   expect(page).to have_content('User was succesfully deleted')
  #
  # end
  #
  #
  # scenario 'Users see an error message if they do not fill in last name' do
  #   visit root_path
  #   click_on 'Sign Out'
  #   click_on 'Users'
  #   click_on 'New User'
  #   fill_in 'Last name', with:'Stetson'
  #   click_on 'Create User'
  #
  #   expect(page).to have_no_content('User was successfully created')
  #   expect(page).to have_content( '2 Errors prohibted this object from being saved')
  #   expect(page).to have_content( 'First name can\'t be blank')
  #   expect(page).to have_content( 'Email can\'t be blank')
  #
  # end



end
