require 'spec_helper'

feature 'editing a comment' do
  scenario 'a visitor can not approve comments' do
    visit article_path(articles(:codefellow))
    page.wont_have_link 'Approve'
  end

  scenario 'an author can approve comments on his own articles' do
    log_in(:author)
    visit article_path(articles(:codefellow))
    page.find('div.comment', text: comments(:troll).body).click_on 'Approve'
    page.wont_have_link 'Approve'

    log_out

    visit article_path(articles(:codefellow))
    page.text.must_include(comments(:troll).body)
  end

  scenario 'an author can not approve comments on other authors articles' do
    log_in(:author)
    visit article_path(articles(:syllabus))
    page.wont_have_link 'Approve'
  end

  scenario 'an editor can approve all comments' do
    log_in(:editor)
    visit article_path(articles(:codefellow))
    page.find('div.comment', text: comments(:troll).body).click_on 'Approve'

    log_out

    visit article_path(articles(:codefellow))
    page.text.must_include(comments(:troll).body)
  end
end
