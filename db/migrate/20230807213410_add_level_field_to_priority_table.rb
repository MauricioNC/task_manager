class AddLevelFieldToPriorityTable < ActiveRecord::Migration[7.0]
  def change
    add_column :priorities, :level, :string, after: "priority"
  end
end
