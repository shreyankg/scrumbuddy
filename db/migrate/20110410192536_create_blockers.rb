class CreateBlockers < ActiveRecord::Migration
  def self.up
    create_table :blockers do |t|
      t.text :description
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :blockers
  end
end
