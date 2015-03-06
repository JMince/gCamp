require 'rails_helper'

feature 'Tasks' do

  before :each do
    @task = Task.create( description: 'Brand New Task', date: '2015-4-10')
    @user1 = User.create(first_name: 'First', last_name: 'Last', email: 'email@mail.com', password: 'securepass', password_confirmation: 'securepass')
    sign_in(@user1)
  end



  scenario 'New task can be added' do
      visit root_path
      click_on 'Tasks'
      click_on 'New Task'
      fill_in 'Description', with: 'Fun stuff'
      fill_in 'Date', with: '2016-4-10'
      click_on 'Create Task'

      expect(page).to have_content('Task was successfully created')
      expect(page).to have_content('Fun stuff')
      expect(page).to have_content('4/10/2016')

    end


  scenario 'User can see Task show page' do
      visit root_path
      click_on 'Tasks'
      click_on 'New Task'
      fill_in 'Description', with: 'More Fun stuff'
      fill_in 'Date', with: '2017-4-10'
      click_on 'Create Task'

      expect(page).to have_content('More Fun stuff')
      expect(page).to have_content('4/10/2017')
      expect(page).to have_content('Task was successfully created')

    end

    scenario 'User can edit a Task from the show page' do
        visit root_path
        click_on 'Tasks'
        click_on 'New Task'
        fill_in 'Description', with: 'Task to be editiled'
        fill_in 'Date', with: '2017-4-11'
        click_on 'Create Task'
        click_on 'Edit'
        fill_in 'Description', with: 'Task to be edited'
        click_on 'Update Task'


        expect(page).to have_content('Task to be edited')
        expect(page).to have_content('4/11/2017')
        expect(page).to have_content('Task was successfully updated')

      end



      scenario 'User can delete tasks' do
        visit root_path
        click_on 'Tasks'
        expect(page).to have_content('Brand New Task')
        click_on 'Delete'

        expect(page).to have_no_content('Brand New Task')

      end


      scenario 'Users see an error message if they do not fill in description' do
        visit root_path
        click_on 'Tasks'
        click_on 'New Task'
        fill_in 'Date', with:'2018-4-13'
        click_on 'Create Task'

        expect(page).to have_no_content('Task was successfully created')
        expect(page).to have_content( '1 Error prohibted this object from being saved')
        expect(page).to have_content( 'Description can\'t be blank')
      end








end
