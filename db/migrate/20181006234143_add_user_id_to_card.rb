class AddUserIdToCard < ActiveRecord::Migration
  def change
    add_column :cards, :user_id, :integer, foreign_key: true
  end
end
