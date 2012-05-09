class TaskOwner < ActiveRecord::Migration
  def self.up
    change_table :tasks do |t|
      t.references :user
    end
  end

  def self.down
    remove_column :tasks, :user
  end
end
