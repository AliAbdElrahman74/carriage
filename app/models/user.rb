class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  devise :database_authenticatable

  #Relations
  has_many :comments
  has_many :list_users
  has_many :lists, :through => :list_users
  has_many :cards

  #Validations
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: true
  validates :username , presence: true, uniqueness: true
  validates :type, :inclusion=> { :in => ["Admin", "Member"] }


  ["admin", "member"].each do |method|
   define_method (method + "?") do
      return type == method.capitalize
   end
  end
end
