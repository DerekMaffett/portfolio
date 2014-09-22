require_relative '../test_helper.rb'

feature 'Home page' do
  scenario 'a new visitor visits the home page' do
    visit root_path
    page.must_have_content 'Portfolio'
  end
end
