class CardPolicy < ApplicationPolicy
  attr_reader :user, :card

  def initialize(user, card)
    @user = user
    @card = card
  end

  def index?

  end

  def create?
    @user.is_admin?
  end

  def update?
    @card.user_id == @user.id or card_in_user_lists
  end

  def destroy?
    @card.user_id == @user.id or card_in_user_lists
  end

  private
  # TODO there is another better way to do it
  def card_in_user_lists
    result = @user.lists.map {|l| l.card_ids.include? @card.id }
    result.reduce(:|)
  end
end
