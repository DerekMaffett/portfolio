require_relative '../test_helper.rb'

# class CanAccessHomeTest < Capybara::Rails::TestCase
#   def test_home_page_has_content
#     visit root_path
#     page.must_have_content "Welcome to Derek Maffett's portfolio"
#   end
# end


describe "root should display a welcome page", :capybara do
  it "displays a greeting" do
    visit root_path
    page.must_have_content "Welcome to Derek Maffett's portfolio"
  end
end
