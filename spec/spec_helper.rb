require 'simplecov'
SimpleCov.start 'rails'
require 'coveralls'
Coveralls.wear!
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
    self.fixture_path = File.join(Rails.root, 'spec', 'fixtures')
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def log_in(role = :editor)
      visit new_user_session_path
      fill_in 'Email', with: users(role).email
      fill_in 'Password', with: 'password'
      click_on 'Log in'
    end

    def log_out
      click_on 'Sign Out'
    end

    def must_show(fixture)
      visit article_path(articles(fixture))
      page.text.must_include(articles(fixture).title)
      page.text.must_include(articles(fixture).body)
    end

    def wont_show(fixture)
      lambda do
        visit article_path(articles(fixture))
        page.text.wont_include(articles(fixture).title)
        page.text.wont_include(articles(fixture).body)
      end.must_raise ActiveRecord::RecordNotFound
    end

    def log_in_twitter_visitor
      initiate_twitter_mock
      click_on 'Log In'
      click_on 'Sign in with Twitter'
    end

    def initiate_twitter_mock
      OmniAuth.config.test_mode = true
      OmniAuth.config.add_mock(
        :twitter,
        uid: '12345',
        info: { nickname: 'test_twitter_user' })
      visit root_path
      Capybara.current_session.driver.request.env['devise.mapping'] =
        Devise.mappings[:user]
      Capybara.current_session.driver.request.env['omniauth.auth'] =
        OmniAuth.config.mock_auth[:twitter]
    end
  end
end
