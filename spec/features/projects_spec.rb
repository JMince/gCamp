require 'rails_helper'


feature 'Projects' do

  before do
    @user1 = User.create(first_name: 'First', last_name: 'Last', email: 'email@mail.com', password: 'securepass', password_confirmation: 'securepass', admin: true)
    sign_in(@user1)
  end

  before :each do
    @project = Project.create( name: 'Super New Project')
  end

scenario 'New project can be added' do
      within(".page-header") do
      click_on 'New Project'
      end
      fill_in 'Name', with: 'Projection Project'
      click_on 'Create Project'

      expect(page).to have_content('Project was successfully created')
      expect(page).to have_content('Projection Project')

    end


    scenario 'User can see Project show page' do
        visit root_path
        within("footer") do
          click_on 'Projects'
        end
        expect(page).to have_content('Super New Project')
        click_on 'Super New Project'

        expect(page).to have_content('Super New Project')
        expect(page).to have_content('Edit')
        expect(page).to have_content('Delete')

      end

      scenario 'User can edit a Project from the show page' do
          visit root_path
          click_on 'Projects'
            within(".page-header") do
            click_on 'New Project'
          end
          fill_in 'Name', with: 'Plojectile'
          click_on 'Create Project'
            within(".breadcrumb") do
            click_on 'Plojectile'
          end
            within(".page-header") do
            click_on 'Edit'
          end
          fill_in 'Name', with: 'Projectile'
          click_on 'Update Project'


          expect(page).to have_content('Projectile')
          expect(page).to have_content('Project was successfully updated')

        end

        scenario 'User can delete projects' do
          visit root_path
          click_on 'Projects'
          expect(page).to have_content('Super New Project')
          click_on 'Super New Project'
          click_on 'Delete'

          expect(page).to have_no_content('Super New Project')

        end


        scenario 'Users see an error message if they do not fill in name' do
          visit root_path
          click_on 'Projects'
            within(".page-header") do
            click_on 'New Project'
            end
          click_on 'Create Project'

          expect(page).to have_no_content('Project was successfully created')
          expect(page).to have_content( '1 Error prohibted this object from being saved')
          expect(page).to have_content( 'Name can\'t be blank')
        end



end
