require 'test_helper'

feature 'sign-up test' do
  scenario 'Filling out a sign-up page with valid information' do
    visit root_path
    click_on 'Sign Up'
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'
    page.text.must_include 'You have signed up successfully'
    current_path.must_match(//)
    page.text.must_include 'Sign Out'
    page.text.wont_include 'There was a problem with your sign-up'
  end
end
