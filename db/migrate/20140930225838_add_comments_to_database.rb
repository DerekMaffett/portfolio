class AddCommentsToDatabase < ActiveRecord::Migration
  def change
    create_table(:comments) do |table|
      table.integer :article_id
      table.text :body
      table.boolean :approved

      table.timestamps
    end
  end
end
