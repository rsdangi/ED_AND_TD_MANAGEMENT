class RenameColumnToComments < ActiveRecord::Migration
  def self.up
  change_table :comments do |t|
  
  t.rename :posts_id, :post_id
  t.rename :users_id, :user_id
end
  end

  def self.down
  end
end
