[ ![Codeship Status for DerekMaffett/portfolio](https://codeship.io/projects/ceb787b0-25a8-0132-1150-5620d5e70b74/status)](https://codeship.io/projects/37237)

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
Very simple authorization has been established which hinges on simple
authentication. Full authorization based on roles will be added in the next
chapter.

# Production Site

www.derekmaffett.com

NOTE: The test suite includes a test that pings the above site to ensure
Heroku is still running the app in production. This is currently timing out
and reporting a failure but not for apparent internal errors. This bug is being
tracked.
