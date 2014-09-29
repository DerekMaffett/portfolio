require 'test_helper.rb'

feature 'deleting an article' do
  scenario 'article is deleting by clicking a link' do
    # Given: An article exists
    visit articles_path
    page.must_have_content 'Becoming a Code Fellow'

    # When: The delete link is clicked from the index view
    page.all('tr').last.click_on 'Destroy'

    # Then: The article no longer exists
    page.wont_have_content 'Becoming a Code Fellow'
  end
end
