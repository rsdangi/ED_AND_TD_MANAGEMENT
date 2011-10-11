class AddColumnToUserCommentStatus < ActiveRecord::Migration
  def self.up
   change_table :user_comment_statuses do |t|
   t.references:user,:comment
   end 
  end

  def self.down
  end
end
