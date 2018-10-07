class CreateJoinTableListsUsers < ActiveRecord::Migration
  def change
    create_table :list_users do |t|
      t.integer :list_id
      t.integer :user_id
      t.index [:list_id, :user_id]
      t.index [:user_id, :list_id]
    end
  end
end
