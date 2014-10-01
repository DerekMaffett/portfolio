class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(approved: true)
    end
  end
end
