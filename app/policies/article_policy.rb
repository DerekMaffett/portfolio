class ArticlePolicy < ApplicationPolicy
  def publish?
    @user.editor?
  end

  def create?
    @user.editor? || @user.author?
  end

  def update?
    @user.editor? || @record.owned_by?(@user)
  end

  def destroy?
    @user.editor?
  end

  def permitted_attributes
    if @user.editor?
      [:title, :body, :published]
    else
      [:title, :body]
    end
  end

  class Scope < Scope
    def resolve
      if user.editor?
        scope.all
      elsif user.author?
        scope.where("author_id = ? OR published = 't'", user.id)
      else
        scope.where(published: true)
      end
    end
  end
end
