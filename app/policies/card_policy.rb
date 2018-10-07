class CardPolicy < ApplicationPolicy
  attr_reader :user, :card

  def initialize(user, card)
    @user = user
    @card = card
  end

  def index?
    true
  end

  def create?
    @user.admin? || card_in_user_lists
  end

  ["update", "destroy"].each do |method|
   define_method (method + "?") do
      @card.user_id == @user.id or (card_in_user_lists && @user.admin?)
   end
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
  # TODO there is another better way to do it
  def card_in_user_lists
    result = @user.lists.map {|l| l.card_ids.include? @card.id }
    result.reduce(:|)
  end
end
