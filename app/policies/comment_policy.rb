class CommentPolicy < ApplicationPolicy
  def approve?
    @user.editor? || @record.article.owned_by?(@user)
  end

  class Scope < Scope
    def resolve
      if @user.editor? || owns_comments_in_scope(scope)
        scope
      else
        scope.where(approved: true)
      end
    end

    def owns_comments_in_scope(scope)
      scope.first.article.author.id == @user.id if scope.present?
    end
  end
end
