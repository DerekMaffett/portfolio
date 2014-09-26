require 'test_helper.rb'

feature 'creating an article' do
  scenario 'An authenticated user submits form data to create a new article' do
    # Given: A signed in user goes to the article index
    log_in
    visit articles_path
    page.wont_have_content 'Test article'
    page.wont_have_content 'Behaviour driven development'

    # When: A form is submitted for a new article
    click_on 'New Article'
    fill_in 'Title', with: 'Test article'
    fill_in 'Body', with: 'Behaviour driven development is a lot of fun!'
    click_on 'Create Article'

    # Then: A new article should show up on the show page
    page.must_have_content 'Test article'
    page.must_have_content 'Behaviour driven development'
    page.has_css? '#author'
    page.text.must_include users(:brook).email
  end
end
