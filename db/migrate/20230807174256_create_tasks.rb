class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.string :description
      t.date :end_date

      t.timestamps
    end
  end
end
