class ArticlePolicy < ApplicationPolicy
  def publish?
    user.editor?
  end

  def create?
    true if user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
