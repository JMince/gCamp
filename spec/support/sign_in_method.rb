def sign_in(user)
  visit signin_path
  fill_in :email, with: user.email
  fill_in :password, with: user.password
  within "form" do
    click_on 'Sign In'
  end
  expect(page).to have_content('You have successfully signed in')
end
