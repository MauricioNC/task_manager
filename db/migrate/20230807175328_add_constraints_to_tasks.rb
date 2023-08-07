class AddConstraintsToTasks < ActiveRecord::Migration[7.0]
  def up
    change_column :tasks, :task_name, :string, null: false, unique: true, default: ""
    change_column :tasks, :description, :string, null: false, default: ""
    change_column :tasks, :end_date, :string, null: false, default: ""
  end

  def down
    change_column :tasks, :task_name, :string, null: false, unique: true
    change_column :tasks, :description, :string, null: false
  end
end
