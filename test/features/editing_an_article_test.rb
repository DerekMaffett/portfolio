require_relative '../test_helper.rb'

feature "Editing an article" do
  scenario "submit form data to edit an article" do
    # Given: an article exists
    @article = Article.create(
      title: "Becoming a Code Fellow",
      body: "means striving for excellence."
      )

    # When: I edit an article
    visit edit_article_path(@article)
    fill_in "Body", with: "Edited text"
    click_on "Update Article"

    # Then: Article should be updated.
    page.must_have_content "Article was successfully updated"
    page.must_have_content "Edited text"
  end
end
