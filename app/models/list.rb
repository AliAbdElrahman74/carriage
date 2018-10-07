class List < ActiveRecord::Base

  has_many :cards
  has_many :comments
  belongs_to :user

  #scopes
  scope :by_admin, -> {List.all}
  scope :by_member, -> (user_id) {where(user_id: user_id)}

end
