class CommentPolicy < ApplicationPolicy
  def approve?
    @user.editor? || @record.article.owned_by?(@user)
  end

  class Scope < Scope
    def resolve
      if @user.editor? || owns_article_in_scope
        @scope
      else
        @scope.where(approved: true)
      end
    end

    def owns_article_in_scope
      @scope.detect { |c| c.article.author == @user }
    end
  end
end
