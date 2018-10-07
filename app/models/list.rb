class List < ActiveRecord::Base

  has_many :cards
  belongs_to :user

  #scopes
  scope :by_admin, -> {List.all}
  scope :by_member, -> (user_id) {where(user_id: user_id)}

end
