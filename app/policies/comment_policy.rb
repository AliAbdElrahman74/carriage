class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def index

  end

  def create
    @user.is_admin?
  end

  def update
    @comment.user_id == @user_id
  end

  def destroy
    @comment.user_id == @user_id
  end
end
