require 'test_helper.rb'

feature 'Editing an article' do
  scenario 'a logged in user submits form data to edit an article' do
    # Given: an article exists
    log_in
    visit articles_path
    page.must_have_content 'Becoming a Code Fellow'

    # When: I edit an article
    visit edit_article_path(articles(:codefellow))
    fill_in 'Body', with: 'Edited text'
    click_on 'Update Article'

    # Then: Article should be updated.
    page.must_have_content 'Article was successfully updated'
    page.must_have_content 'Edited text'
  end
end
