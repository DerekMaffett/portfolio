require 'test_helper.rb'

feature 'creating an article' do
  scenario 'submit form data to create a new article' do
    # Given: A given article does not exist
    visit articles_path
    page.wont_have_content 'Test article'
    page.wont_have_content 'Behaviour driven development'

    # When: A form is submitted for a new article
    visit new_article_path
    fill_in 'Title', with: 'Test article'
    fill_in 'Body', with: 'Behaviour driven development is a lot of fun!'
    click_on 'Create Article'

    # Then: A new article should show up on the show page
    page.must_have_content 'Test article'
    page.must_have_content 'Behaviour driven development'
  end
end
