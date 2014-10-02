require 'spec_helper'

feature 'creating a comment' do
  scenario 'a non-logged-in user cannot submit comments' do
    create_comment
    page.text.must_include 'You need to sign in or sign up before continuing'

    log_in(:editor)
    visit article_path(articles(:codefellow))
    page.text.wont_include 'Trololol'
  end

  scenario 'a logged-in visitor can submit a comment' do
    log_in_twitter_visitor
    create_comment
    log_out
    log_in(:editor)
    visit article_path(articles(:codefellow))
    page.text.must_include 'Trololol'
  end

  scenario 'a new comment can not be seen' do
    log_in_twitter_visitor
    create_comment
    page.text.wont_include 'Trololol'
    page.text.must_include 'Thank you for commenting.'
  end

  scenario 'an empty comment is invalid' do
    log_in_twitter_visitor
    visit article_path(articles(:codefellow))
    fill_in 'Body', with: ''
    click_on 'Submit Comment'

    page.text.must_include 'Invalid comment'
  end
end

def create_comment
  visit article_path(articles(:codefellow))
  fill_in 'Body', with: 'Trololol'
  click_on 'Submit Comment'
end
