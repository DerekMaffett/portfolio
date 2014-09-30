require 'spec_helper'

feature 'visiting the article index' do
  scenario 'a visitor should see only published articles' do
    # Given: A non-logged in user

    # When: The index page is visited
    visit articles_path

    # Then: Content from only published articles should be displayed
    page.text.must_include 'Becoming a Code Fellow'
    page.text.wont_include 'The New FirePhone'
  end

  scenario 'an author should see published articles and her own articles' do
    # Given: a logged-in author
    log_in(:author)

    # When: I visit the index page
    visit articles_path

    # Then: I should see all published articles and only my unpublished articles
    page.text.must_include 'The New FirePhone'
    page.text.must_include 'Becoming a Code Fellow'
    page.text.must_include 'Syllabus'
    page.text.wont_include 'Modifications'
  end

  scenario 'an editor should see all articles, published or unpublished' do
    # Given: a logged-in editor
    log_in(:editor)

    # When: I visit the index page
    visit articles_path

    # Then: I should see all published and unpublished articles
    page.text.must_include 'The New FirePhone'
    page.text.must_include 'Becoming a Code Fellow'
    page.text.must_include 'Syllabus'
    page.text.must_include 'Modifications'
  end
end
