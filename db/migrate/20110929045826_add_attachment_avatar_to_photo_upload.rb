class AddAttachmentAvatarToPhotoUpload < ActiveRecord::Migration
  def self.up
    add_column :photo_uploads, :avatar_file_name, :string
    add_column :photo_uploads, :avatar_content_type, :string
    add_column :photo_uploads, :avatar_file_size, :integer
    add_column :photo_uploads, :avatar_updated_at, :datetime
  end

  def self.down
    remove_column :photo_uploads, :avatar_file_name
    remove_column :photo_uploads, :avatar_content_type
    remove_column :photo_uploads, :avatar_file_size
    remove_column :photo_uploads, :avatar_updated_at
  end
end
