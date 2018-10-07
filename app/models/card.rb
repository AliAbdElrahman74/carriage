class Card < ActiveRecord::Base

  has_many :comments
  belongs_to :list
  belongs_to :user

  #scopes
  scope :by_admin, -> {Card.all}
  scope :by_member, -> (user_id) {member_cards(user_id)}



  private
  def self.member_cards(user_id)
    cards = Set.new
    cards << (where(user_id: user_id) + List.includes(:cards).where(user_id: user_id).map {|list| list.cards}).flatten.uniq
    cards
  end
end
