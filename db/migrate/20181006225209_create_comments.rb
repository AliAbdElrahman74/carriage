class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content

      t.integer :parent_id, index: true, foreign_key: true
      t.integer :card_id,  index: true, foreign_key: true
      t.integer :user_id,  index: true, foreign_key: true
      t.timestamps
    end
  end
end
