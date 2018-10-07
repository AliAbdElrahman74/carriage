class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  devise :database_authenticatable

  has_many :comments
  has_many :lists
  has_many :cards

  ["admin", "member"].each do |method|
   define_method (method + "?") do
      return type == method.capitalize
   end
  end
end
