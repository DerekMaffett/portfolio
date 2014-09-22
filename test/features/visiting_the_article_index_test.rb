require_relative '../test_helper.rb'

feature 'visiting the article index' do
  scenario 'with existing articles, show list' do
    # Given: An article exists

    # When: The index page is visited
    visit articles_path

    # Then: Content from the article should be displayed
    page.must_have_content 'Becoming a Code Fellow'
  end
end
