require 'spec_helper'

feature 'creating a comment' do
  scenario 'a new comment can not be seen' do
    visit article_path(articles(:codefellow))
    fill_in 'Body', with: 'Trololol'
    click_on 'Submit Comment'

    page.text.wont_include 'Trololol'
    page.text.must_include 'Thank you for commenting.'
  end
end
