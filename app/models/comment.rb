class Comment < ApplicationRecord

  has_many :replies, dependent: :destroy, :class_name => "Comment", :foreign_key => "parent_id"
  belongs_to :parent, :class_name => "Comment", optional: true

  belongs_to :user
  belongs_to :card

  #scopes

  scope :by_comment -> (parent_id) {where(parent_id: parent_id).order(created_at: :desc)}
  scope :by_card -> (card_id) {where(card_id: card_id, parent_id: nil).order(created_at: :desc)}
end
