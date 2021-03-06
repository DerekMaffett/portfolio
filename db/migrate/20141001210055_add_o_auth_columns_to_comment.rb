class AddOAuthColumnsToComment < ActiveRecord::Migration
  def change
    add_column :comments, :author, :string
    add_column :comments, :author_url, :string
    add_column :comments, :author_email, :string
    add_column :comments, :user_ip, :string
    add_column :comments, :user_agent, :string
    add_column :comments, :referrer, :string
  end
end
