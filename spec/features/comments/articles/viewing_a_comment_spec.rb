require 'spec_helper'

feature 'viewing a comment' do
  scenario 'a visitor can only see a comment if it is approved' do
    visit article_path(articles(:codefellow))

    page.text.must_include(comments(:kudos).body)
    page.text.wont_include(comments(:troll).body)
  end

  scenario 'an author can see comments on his own article' do
    log_in(:author)

    visit article_path(articles(:codefellow))

    page.text.must_include(comments(:troll).body)
  end

  scenario 'an author can not see comments on other authors articles' do
    log_in(:author)

    visit article_path(articles(:syllabus))

    page.text.wont_include(comments(:buystuff).body)
  end

  scenario 'an editor can see all comments' do
    log_in(:editor)

    visit article_path(articles(:syllabus))

    page.text.must_include(comments(:buystuff).body)
  end
end
