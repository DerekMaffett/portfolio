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

Comments are also permitted on articles for any signed-in user. Meticulous
scoping ensuresthat only comments which users are allowed to interact with on
some level are shown. Comments must be approved before they are permitted to be
seen publically, and only the editors and the authors of a particular article
are permitted to approve comments.

Omniauth has been implemented via Twitter. Whether through regular sign-up or
Twitter Omniauth, a user defaults to having a nil role, which permits it through
Devise :authenticate_user! filters (applied only to comments), but does not
work for Pundit authorization calls.


# Production Site

www.derekmaffett.com
