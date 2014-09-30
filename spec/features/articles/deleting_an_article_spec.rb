require 'spec_helper.rb'

feature 'deleting an article' do
  scenario 'a visitor cannot see delete link in index view' do
    # Given: a non-logged-in visitor

    # When: I visit the index page
    visit articles_path

    # Then: I won't see a delete link
    page.wont_have_link 'Destroy'
  end

  scenario 'a visitor cannot see Destroy link in show view' do
    # Given: a non-logged-in visitor

    # When: I visit the show page
    visit article_path(articles(:codefellow))

    # Then: I won't see a Destroy link
    page.wont_have_link 'Destroy'
  end

  scenario 'an author cannot see Destroy link in index view' do
    # Given: a logged-in author
    log_in(:author)

    # When: I visit the index page
    visit articles_path

    # Then: I won't see a Destroy link
    page.wont_have_link 'Destroy'
  end

  scenario 'an author cannot see Destroy link in show view' do
    # Given a logged-in author
    log_in(:author)

    # When: I visit the show page
    visit article_path(articles(:codefellow))

    # Then: I won't see a Destroy link
    page.wont_have_link 'Destroy'
  end

  scenario 'an editor can delete published articles' do
    # Given: A logged-in editor
    log_in(:editor)

    # When: The delete link is clicked from the index view
    visit articles_path
    page.find('tr', text: articles(:codefellow).title).click_on 'Destroy'

    # Then: The article no longer exists
    page.text.must_include 'Article was successfully destroyed'
    page.text.wont_include articles(:codefellow).title
  end

  scenario 'an editor can delete unpublished articles' do
    # Given: a logged-in editor
    log_in(:editor)

    # When: The delete link is clicked from the index view
    visit articles_path
    page.find('tr', text: articles(:firephone).title).click_on 'Destroy'

    # Then: The article no longer exists
    page.text.wont_include articles(:firephone).title
    page.text.must_include 'Article was successfully destroyed'
  end
end
