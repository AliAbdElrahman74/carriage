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

  ["update", "destroy", "assign_member", "unassign_member"].each do |method|
   define_method (method + "?") do
      @user.admin? && his_own_list
   end
  end

  class Scope < Scope
    def resolve
      if @user.admin?
        scope.by_admin
      else
        @user.lists
      end
    end
  end

  private
  def his_own_list
    @user.list_ids.include? @list.id
  end
end
