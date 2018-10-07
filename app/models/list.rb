class List < ActiveRecord::Base

  #Relations
  has_many :cards
  has_many :comments
  has_many :users, :through => :list_users
  has_many :list_users

  #Validations
  validates :title , presence: true


  #scopes
  scope :by_admin, -> {List.all}

end
