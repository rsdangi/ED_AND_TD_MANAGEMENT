class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :description
       t.references :posts, :users
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
