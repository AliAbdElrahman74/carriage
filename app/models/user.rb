class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  devise :database_authenticatable

  has_many :comments
  has_many :list_users
  has_many :lists, :through => :list_users
  has_many :cards

  ["admin", "member"].each do |method|
   define_method (method + "?") do
      return type == method.capitalize
   end
  end
end
