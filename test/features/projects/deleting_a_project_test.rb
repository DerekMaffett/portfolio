require 'test_helper'

feature 'deleting an article' do
  scenario 'when the delete link is clicked, the article should be deleted' do
    visit project_path(projects(:codeschool))
    page.text.must_include 'Code School'
    click_on 'Delete'
    page.text.wont_include 'Code School'
  end
end
