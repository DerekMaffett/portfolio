require 'test_helper'

feature 'HomePageInProductionTest' do
  scenario 'page is deployed', js: true do
    visit 'http://www.derekmaffett.com'
    page.must_have_content 'Portfolio'
  end
end
