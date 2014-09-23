require 'test_helper'

feature 'creating a project' do
  scenario 'a project does not yet exist' do
    visit projects_path
    click_on 'New Project'
    fill_in 'Name', with: 'Awesome Code Fellows Project'
    fill_in 'Description', with: 'This project was made using Ruby on Rails'
    click_on 'Create Project'
    page.text.must_include 'Project has been created'
    page.must_have_css '.info'
    page.status_code.must_equal 200
  end
end
