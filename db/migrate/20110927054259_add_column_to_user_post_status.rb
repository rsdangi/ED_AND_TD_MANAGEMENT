class AddColumnToUserPostStatus < ActiveRecord::Migration
  def self.up
   change_table :user_post_statuses do |t|
   t.references:user,:post
   end 
  end

  def self.down
  end
end
