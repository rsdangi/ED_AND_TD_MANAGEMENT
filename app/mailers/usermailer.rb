class Usermailer < ActionMailer::Base
  default :from => "dangi@systematixtechnoctrates.com"
 	def newemail(post)
   @users_email = User.all.map(&:email)
  # @subject = post.title
  
#   @users.each do |user|
    mail(:to=>@users_email ,:subject=>post.title ,:message=>post.description)
  # end

  end
end
