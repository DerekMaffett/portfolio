require 'test_helper'

feature 'test for the presence of Foundation 5' do
  scenario 'the browser has received css files', js: true do
    visit root_path
    page.must_have_css 'meta[class="foundation-mq-topbar"]', visible: false
  end
end
