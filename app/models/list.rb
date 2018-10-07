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

  def self.assign_member(params, list)
    user_id = params[:user_id].to_i
    user_ids = list.user_ids
    if user_ids.include? user_id
      return  "The resource is already existed"
    end
    list.user_ids = user_ids + [user_id]
    return "success"
  end

  def self.unassign_member(params, list)
    user_id = params[:user_id].to_i
    user_ids = list.user_ids
    unless user_ids.include? user_id
      return "The resource is already not existed"
    end
    list.user_ids = user_ids - [user_id]
    return "success"
  end

end
