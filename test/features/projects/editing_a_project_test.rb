require 'test_helper'

feature 'editing a project' do
  before do
    @project = Project.create(
      name: 'Terrible Project', description: 'This is really bad'
      )
  end

  scenario 'a valid edit is submitted' do
    # Given a project exists

    # When it is edited with valid data
    visit edit_project_path(@project)
    fill_in 'Name', with: 'Awesome Project'
    fill_in 'Description', with: 'Now this is pretty good!'
    click_on 'Update Project'

    # Then it should show the new data

    page.text.wont_include 'Terrible Project'
    page.text.must_include 'Awesome Project'
    page.text.must_include 'Now this is pretty good!'
    page.text.must_include 'Project has been updated'
    page.must_have_css '.success'
  end

  scenario 'an invalid edit is submitted' do
    # Given an existing project

    # When I submit invalid changes
    visit edit_project_path(@project)
    fill_in 'Name', with: 'Awe'
    click_on 'Update Project'

    # Then the changes should not be saved, and I should get to try again
    page.text.must_include 'Project could not be updated'
    page.must_have_css '.alert'
    page.text.must_include 'Name is too short'
    visit project_path(@project)
    page.text.must_include 'Terrible Project'
    page.text.wont_include 'Awesome Project'
  end
end
