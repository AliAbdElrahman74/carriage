class AddTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :type, :string, default: "Member"
  end
end
