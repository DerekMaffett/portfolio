# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the
# db with db:setup).
ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  unless table == 'schema_migrations'
    ActiveRecord::Base.connection.execute("DELETE FROM #{table}")
  end
end

user = User.create(email: 'derek@email.com', password: 'password')

articles = Article.create([
  {
    title: 'Becoming a Code Fellow',
    body: 'Means striving for excellence',
    published: true
  },
  {
    title: 'The New Fire Phone',
    body: 'Amazon released a new phone',
    published: false
  }
])

user.articles << articles
