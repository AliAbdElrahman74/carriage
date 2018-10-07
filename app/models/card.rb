class Card < ActiveRecord::Base

  #Relations
  has_many :comments
  belongs_to :list
  belongs_to :user

  #Validations
  validates :title , presence: true
  validates :user, presence: true
  validates :list, presence: true

  #scopes
  scope :by_admin, -> {Card.all}
  scope :by_member, -> (user_id) {member_cards(user_id)}



  private
  def self.member_cards(user_id)
    cards = Set.new
    cards << (where(user_id: user_id) + User.includes(lists: [:cards]).find(user_id).lists.map {|list| list.cards}).flatten.uniq
    cards
  end
end
