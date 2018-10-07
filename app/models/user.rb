class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  devise :database_authenticatable

  has_many :comments
  has_many :lists
  has_many :cards
end
