class UserPostStatus < ActiveRecord::Base
	belongs_to :user ,:foreign_key => 'users_id'
  belongs_to :post 
	 #validate :user_can_like_post_at_a_time
	
# 	def user_can_like_post_at_a_time
#     status = UserPostStatus.where("user_id = ? AND post_id = ?",user_id,post_id).all
# 		if status.size > 0
#       errors.add(:user_id, "Alreay exist")
#     end
#   end

end
