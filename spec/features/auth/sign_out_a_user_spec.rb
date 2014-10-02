require 'spec_helper'

feature 'Sign out a user' do
  scenario 'A signed in user should be signed out after clicking the sign out
            link' do
    log_in
    click_on 'Sign Out'
    page.text.must_include 'Signed out successfully'
    page.text.must_include 'Log In'
    current_path.must_match(//)
    page.text.wont_include 'Sign Out'
  end
end
