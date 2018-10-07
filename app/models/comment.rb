class Comment < ActiveRecord::Base

  #Relations
  has_many :replies, dependent: :destroy, :class_name => "Comment", :foreign_key => "parent_id"
  belongs_to :parent, :class_name => "Comment"
  belongs_to :user
  belongs_to :card
  belongs_to :list

  #Validations
  validates :content , presence: true
  validates :user, presence: true
  validates :list, presence: true
  validates :card, presence: true

  #scopes
  scope :by_comment, -> (parent_id) {where(parent_id: parent_id).order(created_at: :desc)}
  scope :by_card, -> (card_id) {where(card_id: card_id, parent_id: nil).order(created_at: :desc)}
  scope :by_admin, -> {Comment.all}
  scope :by_member, -> (user_id) {member_comments(user_id)}


  private
  def self.member_comments(user_id)
    (where(user_id: user_id) + List.includes(:comments).where(user_id: user_id).map {|list| list.comments}).flatten.uniq

  end
end
