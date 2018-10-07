class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def index?
    true
  end

  def create?
    @user.is_admin? || his_own_list
  end

  def update?
    @comment.user_id == @user_id or (his_own_list && @user.admin?)
  end

  def destroy?
    @comment.user_id == @user_id or (his_own_list && @user.admin?)
  end

  class Scope < Scope
    def resolve
      if @user.admin?
        scope.by_admin
      else
        scope.by_member(@user.id)
      end
    end
  end

  private
  def his_own_list
    @user.list_ids.include? @comment.list_id
  end
end
