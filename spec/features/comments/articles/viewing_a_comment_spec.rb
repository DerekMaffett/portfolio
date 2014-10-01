require 'spec_helper'

feature 'viewing a comment' do
  scenario 'a comment is only seen if it is approved' do
    visit article_path(articles(:codefellow))

    page.text.must_include(comments(:kudos).body)
    page.text.wont_include(comments(:troll).body)
  end
end
