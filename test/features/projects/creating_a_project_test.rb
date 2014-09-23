require 'test_helper'

feature 'creating a project' do
  scenario 'a valid project is submitted' do
    visit projects_path
    click_on 'New Project'
    fill_in 'Name', with: 'Awesome Code Fellows Project'
    fill_in 'Description', with: 'This project was made using Ruby on Rails'
    click_on 'Create Project'
    page.text.must_include 'Awesome Code Fellows Project'
    page.text.must_include 'Project has been created'
    page.must_have_css '.success'
    page.status_code.must_equal 200
  end

  scenario 'an invalid project is submitted' do
    # Given: invalid project data is submitted
    visit projects_path
    click_on 'New Project'

    # When: The form is submitted with a blank name and description
    fill_in 'Name', with: 'P'
    click_on 'Create Project'

    # Then: The form should be redisplayed with an error message
    current_path.must_match(/projects$/)
    page.text.must_include 'Project could not be saved'
    page.text.must_include 'Name is too short'
    page.text.must_include "Description can't be blank"
    page.must_have_css '.alert'
  end
end
