class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.editor?
        scope
      else
        scope.where(approved: true)
      end
    end
  end
end
