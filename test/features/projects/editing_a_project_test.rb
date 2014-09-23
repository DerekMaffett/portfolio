require 'test_helper'

feature 'editing a project' do
  scenario 'a valid edit is submitted' do
    # Given a project exists

    # When it is edited with valid data
    visit edit_project_path(projects(:codeschool))
    fill_in 'Name', with: 'Edited project'
    fill_in 'Description', with: 'This is new!'
    click_on 'Update Project'

    # Then it should show the new data
    page.text.wont_include 'Code School'
    page.text.must_include 'Edited project'
    page.text.must_include 'This is new!'
    page.text.must_include 'Project has been updated'
    page.must_have_css '.success'
  end

  scenario 'an invalid edit is submitted' do
    # Given an existing project

    # When I submit invalid changes
    visit edit_project_path(projects(:codeschool))
    fill_in 'Name', with: 'Err'
    click_on 'Update Project'

    # Then the changes should not be saved, and I should get to try again
    page.text.must_include 'Project could not be updated'
    page.must_have_css '.alert'
    page.text.must_include 'Name is too short'
    visit project_path(projects(:codeschool))
    page.text.must_include 'Code School'
    page.text.wont_include 'Err'
  end
end
