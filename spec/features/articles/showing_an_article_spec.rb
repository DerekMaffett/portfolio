require 'spec_helper'

feature 'showing an article' do
  scenario 'a visitor should be able to access a published article' do
    # Given: a visitor isn't logged in

    # When: I attempt to access a published article manually
    # Then: I should see the article
    must_show(:codefellow)
  end

  scenario 'a visitor should not be able to access an unpublished article' do
    # Given: a visitor isn't logged in

    # When: I attempt to access an unpublished article manually
    # Then: I should not see the article
    wont_show(:firephone)
  end

  scenario 'an author should be able to access any published article' do
    # Given: an author is logged in
    log_in(:author)

    # When: I attempt to access the published article of another author
    # Then: I should see the article
    must_show(:syllabus)
  end

  scenario 'an author should be able to access their own unpublished article' do
    # Given: an author is logged in
    log_in(:author)

    # When: I attempt to access my own unpublished article
    # Then: I should see the article
    must_show(:firephone)
  end

  scenario "an author should not be able to access another author's
    unpublished article" do
    # Given: an author is logged in
    log_in(:author)

    # When: I attempt to access the unpublished article of another author
    # Then: I should not see the article
    wont_show(:class_mods)
  end

  scenario 'an editor should be able to access published articles' do
    # Given: an editor is logged in
    log_in(:editor)

    # When: I attempt to access a published article
    # Then: I should see the article
    must_show(:codefellow)
  end

  scenario 'an editor should be able to access unpublished articles' do
    # Given: an editor is logged in
    log_in(:editor)

    # When: I attempt to access an unpublished article
    # Then: I should see the article
    must_show(:firephone)
  end
end
