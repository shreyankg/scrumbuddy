class TaskType < ActiveRecord::Migration
  def self.up
    change_table :tasks do |t|
      t.string :task_type
    end
  end

  def self.down
    remove_column :tasks, :task_type
  end
end
