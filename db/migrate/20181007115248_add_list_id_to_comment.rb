class AddListIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :list_id, :integer, foreign_key: true
  end
end
