require 'rails_helper'

feature 'Tasks' do

  before :each do
    @user1 = User.create(first_name: 'First', last_name: 'Last', email: 'email@mail.com', password: 'securepass', password_confirmation: 'securepass')
    sign_in(@user1)
    @project_new = Project.create!( name:"New Project")
    @task_new = @project_new.tasks.create!(description: 'Fun Task', date: '2016-04-04')

  end



  scenario 'New task can be added' do
      visit new_project_task_path(@project_new)
      fill_in :task_description, with: 'Fun Task'
      fill_in :task_date, with: '2016-07-26'
      click_on 'Create Task'
      expect(page).to have_content('Task was successfully created')
      expect(page).to have_content('Fun Task')
      expect(page).to have_content('07/26/2016')
    end


  scenario 'User can see Task show page when clicking on a link' do
    visit project_tasks_path(@project_new)
      click_on @task_new.description

      expect(page).to have_content('Fun Task Due On: 04/04/2016')

    end

      scenario 'User can edit a fun-like Task' do
        visit project_task_path(@project_new, @task_new)
        click_on 'Edit'
        fill_in :task_description, with: 'Super Fun Task'
        click_on 'Update Task'
        expect(page).to have_content('Task was successfully updated')
        expect(page).to have_content('Super Fun Task')

      end



      scenario 'User can delete a task' do
        visit project_tasks_path(@project_new)
        page.find(".glyphicon-remove").click
        expect(page).to have_no_content('Fun Task')

      end


      scenario 'Users see an error message if they do not fill in description' do
        visit new_project_task_path(@project_new)
        fill_in 'Date', with:'2018-4-13'
        click_on 'Create Task'

        expect(page).to have_no_content('Task was successfully created')
        expect(page).to have_content( '1 Error prohibted this object from being saved')
        expect(page).to have_content( 'Description can\'t be blank')
      end



end
