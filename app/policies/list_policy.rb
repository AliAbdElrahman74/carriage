class ListPolicy < ApplicationPolicy
attr_reader :user, :list

  def initialize(user, list)
    @user = user
    @list = list
  end

  def create
    @user.is_admin?
  end
end
