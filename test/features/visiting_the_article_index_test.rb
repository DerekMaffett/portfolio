require_relative '../test_helper.rb'

feature "visiting the article index" do
  scenario "with existing articles, show list" do
    Article.create(
      title: "Becoming a Code Fellow",
      body: "means striving for excellence."
      )
    visit articles_path
    page.must_have_content "Code Fellow"
  end
end
