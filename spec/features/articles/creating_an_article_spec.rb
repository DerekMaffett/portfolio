require 'spec_helper.rb'

feature 'creating an article' do
  scenario 'An author submits form data to create a new article' do
    # Given: A signed in author goes to the article index
    log_in(:author)
    visit articles_path
    page.text.wont_include 'Test article'
    page.text.wont_include 'Behaviour driven development'

    # When: A form is submitted for a new article
    click_on 'New Article'
    fill_in 'Title', with: 'Test article'
    fill_in 'Body', with: 'Behaviour driven development is a lot of fun!'
    click_on 'Create Article'

    # Then: A new article should show up on the show page
    page.text.must_include 'Status: Unpublished'
    page.text.must_include 'Test article'
    page.text.must_include 'Behaviour driven development'
    page.has_css? '#author'
    page.text.must_include users(:author).email
  end

  scenario 'unauthenticated visitors can not visit the new_article_path' do
    # Given: A visitor who is not signed in

    # When: The new_article_path is accessed
    visit new_article_path

    # Then: The visitor should be refused access
    page.text.must_include 'You are not authorized to perform this action'
    page.text.wont_include 'New article'
    current_path.wont_match(/articles\/new$/)
  end

  scenario 'unauthenticated visitors can not see new article button' do
    # Given: A visitor who is not signed in

    # When: The articles_path is accessed
    visit articles_path

    # Then: The visitor should not see a new article button
    page.wont_have_link 'New Article'
  end

  scenario 'authors can not publish' do
    # Given: A signed-in author
    log_in(:author)

    # When: I visit the new_article_path
    visit new_article_path

    # Then: There should be no checkbox for publishing
    page.wont_have_field 'Published'
  end

  scenario 'editors can publish' do
    # Given: A signed-in editor
    log_in(:editor)

    # When: I visit the new_article_path
    visit new_article_path

    # Then: There is a checkbox for publishing
    page.must_have_field 'Published'

    # And When: I submit the form
    fill_in 'Title', with: 'Article of Editor'
    fill_in 'Body', with: 'This is an article publishable by the editor'
    check 'Published'
    click_on 'Create Article'

    # Then: The published article should be shown
    page.text.must_include 'Status: Published'
    page.text.must_include 'Article of Editor'
    page.text.must_include 'This is an article publishable by the editor'
  end
end
