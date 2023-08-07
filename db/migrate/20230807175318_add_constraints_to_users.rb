class AddConstraintsToUsers < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :name, :string, null: false, default: ""
    change_column :users, :email, :string, null: false, unique: true, default: ""
    change_column :users, :password, :string, null: false, default: ""
  end

  def down
    change_column :users, :name, :string, null: false
    change_column :users, :email, :string, null: false
    change_column :users, :password, :string, null: false, unique: true
  end
end
