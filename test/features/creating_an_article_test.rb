require_relative '../test_helper.rb'

feature "creating an article" do
  scenario "submit form data to create a new article" do
    visit new_article_path
    fill_in "Title", with: "Test article"
    fill_in "Body", with: "Behaviour driven development is a lot of fun!"
    click_on "Create Article"
    page.must_have_content "Test article"
    page.must_have_content "Behaviour driven development"
  end
end
