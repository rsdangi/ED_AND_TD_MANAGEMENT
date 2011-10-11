class CreateUserPostStatuses < ActiveRecord::Migration
  def self.up
    create_table :user_post_statuses do |t|
      t.integer :status

      t.timestamps
    end
  end

  def self.down
    drop_table :user_post_statuses
  end
end
