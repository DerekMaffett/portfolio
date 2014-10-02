require 'spec_helper'

feature 'showing a project' do
  scenario 'the show view should show a single project' do
    visit project_path(projects(:codeschool))
    page.text.must_include 'Code School'
    page.text.must_include 'wonderful interactive website'
    page.text.wont_include 'Google'
  end
end
