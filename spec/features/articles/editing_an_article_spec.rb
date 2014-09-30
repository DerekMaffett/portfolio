require 'spec_helper'

feature 'Editing an article' do
  scenario 'a visitor should not be able to edit any article' do
    # Given: a non-logged-in visitor

    # When: I attempt to edit an article
    visit edit_article_path(articles(:codefellow))

    # Then: I should be sent back with a message that I am not authorized
    page.text.must_include 'You are not authorized to perform this action'
    current_path.wont_match(/edit$/)
  end

  scenario 'a visitor should not see the edit button in the index view' do
    # Given: a non-logged-in visitor

    # When: I visit the index page
    visit articles_path

    # Then: I should not see an edit link
    page.wont_have_link 'Edit'
  end

  scenario 'a visitor should not see the edit button in the show view' do
    # Given: a non-logged-in visitor

    # When: I visit the show page
    visit article_path(articles(:codefellow))

    # Then: I should not see an edit link
    page.wont_have_link 'Edit'
  end

  scenario 'an author should be able to edit his own articles' do
    # Given: a logged-in author
    log_in(:author)

    # When: I fill out the edit form for my article
    visit edit_article_path(articles(:firephone))
    fill_in 'Body', with: 'Edited Text'
    click_on 'Update Article'

    # Then: The article should be updated
    page.text.must_include 'Article was successfully updated'
    page.text.must_include 'Edited Text'
  end

  scenario "an author should not be able to edit other author's articles" do
    # Given: a logged-in author
    log_in(:author)

    # When: I attempt to edit another author's article
    visit edit_article_path(articles(:syllabus))

    # Then: I should be refused access
    page.text.must_include 'You are not authorized to perform this action'
    current_path.wont_match(/edit$/)
  end

  scenario 'an author should not be able to publish his own articles' do
    # Given: a logged-in author
    log_in(:author)

    # When: an author attempts to publish his own article
    visit edit_article_path(articles(:firephone))

    # Then: there will be no way to do so
    page.text.wont_include 'Published'
  end

  scenario 'an editor should be able to edit any article' do
    # Given: a logged-in editor
    log_in(:editor)

    # When: I attempt to edit an article
    visit edit_article_path(articles(:codefellow))
    fill_in 'Body', with: 'Edited Text'
    click_on 'Update Article'

    # Then: Article should be updated.
    page.text.must_include 'Article was successfully updated'
    page.text.must_include 'Edited Text'
  end

  scenario 'an editor should be able to publish an article' do
    # Given: a logged-in editor
    log_in(:editor)

    # When: I attempt to publish an article
    visit edit_article_path(articles(:firephone))
    check 'Published'
    click_on 'Update Article'

    # Then: The article should be published and visible to visitors
    page.text.must_include articles(:firephone).title
    page.text.must_include 'Status: Published'

    # And When: A visitor goes to the index page
    log_out
    visit articles_path

    # Then: The article should be visible
    page.text.must_include articles(:firephone).title
  end
end
