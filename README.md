[![Coverage Status](https://img.shields.io/coveralls/DerekMaffett/portfolio.svg)](https://coveralls.io/r/DerekMaffett/portfolio?branch=ch8)

[![Codeship Status for DerekMaffett/portfolio](https://codeship.io/projects/ceb787b0-25a8-0132-1150-5620d5e70b74/status)](https://codeship.io/projects/37237)

# Description

This is my personal portfolio site. It uses a simple layout generated in
Foundation 5 using the rails_layout gem, and slightly modified beyond that.
The primary purpose of this is to have a set of images and links to projects
I've worked on, with a small description of each one.

Projects can be controlled via a basic rails CRUD interface, fully supported
with flash messages styled appropriately using Foundation classes. Image url's
can be added to projects, with the standard storage being on Amazon S3.

Authentication has been added to the articles controller using the standard
Devise modules, and articles have been associated with users who create them.

Authorization has also been added to the articles controller using Pundit.
Visitors are still prevented from manipulating resources using Devise, but now
article creation has been separated into author and editor roles. Authors can
make new articles and edit them, but can not publish them. Editors have full
control over the site. In addition to authorization, scopes are also employed
to limit authors to only seeing published articles and their own drafts, while
visitors can only see published articles and editors can see everything.

# Production Site

www.derekmaffett.com

# Problems

One noticeable problem with the coding here is the avoidance of unnecessary nil
checks. All authorizations assume that current_user will return a real user
object, but visitors don't permit that when they're not logged in. I can avoid
nil checks in the policy class by first blocking off all authorizable actions
to only authenticated users using Devise. However, this doesn't solve the
problem of what to do when using policy helper methods in the views. For
example, in the index (accessible by all), I might want to hide certain buttons
unless the user is authorized for a given action. However, since the policy
class is exposed to non-signed-in visitors, nil checks become necessary either
in the view (which isn't very DRY) or else in the policy class (which I find
distasteful at best since it means I end up patching all the methods with
nil checks that don't really contribute much of anything beyond holding the
program together). I suspect there is a better way of doing this and would
appreciate any feedback on it.

Also, I found little support within Capybara for issuing direct requests to
controller actions as would be necessary to test whether even a normally
impossible request for a deletion, update, or creation is possible. While the
implemenation I used does lock them down, it's not supported well within the
integration tests - functional tests may be necessary to test against tools
such as curl.
