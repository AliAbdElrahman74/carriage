class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :title
      t.text :description


      t.timestamps
    end
    add_reference :cards, :list, foreign_key: true
  end
end
