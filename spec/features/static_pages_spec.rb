require 'spec_helper'

feature 'Home page' do
  scenario 'a new visitor visits the home page' do
    visit root_path
    page.must_have_content 'Portfolio'
  end
end
