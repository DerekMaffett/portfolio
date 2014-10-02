require 'spec_helper'

feature 'sign in' do
  scenario 'sign in with twitter works' do
    log_in_twitter_visitor
    page.text.must_include 'test_twitter_user, you are signed in!'
  end
end
