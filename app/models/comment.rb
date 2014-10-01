class Comment < ActiveRecord::Base
  belongs_to :article

  validates :body, presence: true

  def unapproved?
    !self.approved
  end
end
