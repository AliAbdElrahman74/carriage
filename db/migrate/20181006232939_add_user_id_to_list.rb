class AddUserIdToList < ActiveRecord::Migration
  def change
    add_column :lists, :user_id, :integer, foreign_key: true
  end
end
