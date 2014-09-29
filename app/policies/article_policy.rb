class ArticlePolicy < ApplicationPolicy
  def publish?
    user.editor?
  end

  def create?
    true
  end

  def update?
    (user.editor? || record.owned_by?(user)) if user
  end

  def permitted_attributes
    if user.editor?
      [:title, :body, :published]
    else
      [:title, :body]
    end
  end

  class Scope < Scope
    def resolve
      if user && user.editor?
        scope.all
      elsif user && user.author?
        scope.where("author_id = ? OR published = 't'", user.id)
      else
        scope.where(published: true)
      end
    end
  end
end
