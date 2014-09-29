class Article < ActiveRecord::Base
  belongs_to :author, class_name: 'User'

  def owned_by?(user)
    author_id == user.id
  end
end
