require 'test_helper'

feature 'Confirm Rails Layout' do
  scenario 'on page load' do
    visit root_path
    page.must_have_css 'li.toggle-topbar'
  end
end
