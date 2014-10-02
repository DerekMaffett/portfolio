require 'spec_helper'

feature 'showing project index' do
  scenario 'valid projects should show up on the index view' do
    visit projects_path
    page.text.must_include 'Code School'
    page.text.must_include 'Google'
  end
end
