class ListPolicy < ApplicationPolicy
attr_reader :user, :list

  def initialize(user, list)
    @user = user
    @list = list
  end



  def index?
    true
  end

  def create?
    @user.is_admin?
  end

  def update?
    @user.admin? && his_own_list
  end

  def destroy?

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
    @user.list_ids.include? @list.id
  end
end
