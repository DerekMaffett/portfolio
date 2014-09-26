ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
require 'minitest/rails'
require 'minitest/rails/capybara'
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

Minitest::Reporters.use! Minitest::Reporters::ProgressReporter.new

module ActiveSupport
  class TestCase
    ActiveRecord::Migration.check_pending!

    # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests
    # in alphabetical order.
    #
    # Note: You'll currently still have to declare fixtures explicitly
    # in integration tests
    # -- they do not yet inherit this setting
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def log_in
      visit root_path
      click_on 'Log In'
      fill_in 'Email', with: users(:brook).email
      fill_in 'Password', with: 'brookpassword'
      click_on 'Log in'
    end
  end
end
