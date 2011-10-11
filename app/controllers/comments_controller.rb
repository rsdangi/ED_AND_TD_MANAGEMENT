class CommentsController < ApplicationController
 def index
   
 end

 def show

 end

 def new 
 
 @post = Post.find(params[:post_id])
 @comments = Comment.new
 end

 def create
 debugger
	comment = Comment.new(:description => params[:description], :user_id => params[:user_id], :post_id => params[:post_id])
	render :json=>comment.to_json
 end

 def edit
 end

 def update
 end

 def destroy
     comment = Comment.find(params[:id])
     if comment.user_id==params[:user_id].to_i
       comment.destroy
       redirect_to :controller=>'posts', :action => 'index'
     else
       redirect_to :controller=>'posts', :action => 'index' 
     end
 end
 
 def comment_status_like
  @comment	=	UserCommentStatus.where("user_id = ? AND comment_id = ?",params[:user_id],params[:comment_id])
	 if @comment.blank?
    @comment = UserCommentStatus.new(:status=>'1' , :user_id=> params[:user_id] , :comment_id =>  params[:comment_id])
    @comment.save
    redirect_to :controller=>'posts', :action => 'index'
   else
    redirect_to :controller=>'posts', :action => 'index'
   end
 end

 def comment_status_unlike
  @comment	=	UserCommentStatus.where("user_id = ? AND comment_id = ?",params[:user_id],params[:comment_id])
	 if @comment.blank?
    @comment = UserCommentStatus.new(:status=>'0' , :user_id=> params[:user_id] , :comment_id =>  params[:comment_id])
    @comment.save
    redirect_to :controller=>'posts', :action => 'index'
   else
    redirect_to :controller=>'posts', :action => 'index'
   end
 end

 def ajax_comment_status_like 
	 like_unlike_value = params[:Like_unlike_value]
   @comment	=	UserCommentStatus.where("user_id = ? AND comment_id = ?" ,params[:user_id],params[:comment_id])
    if like_unlike_value=="like"
				if @comment.blank?
					@comment = UserCommentStatus.new(:status=>'1' , :user_id=> params[:user_id] , :comment_id => params[:comment_id])
				elsif @comment.first.status==1
        elsif @comment.first.status==0
                      @status = @comment.first
                      @status.update_attributes(:status=>'1')
        end
    elsif like_unlike_value=="unlike"
           if @comment.blank?
              @comment = UserCommentStatus.new(:status=>'0' , :user_id=> params[:user_id] , :comment_id =>  params[:comment_id])
              @comment.save
           elsif @comment.first.status==0
           elsif @comment.first.status==1
                       @status = @comment.first
                       @status.update_attributes(:status=>'0')
           end
      end 
	 @response= UserCommentStatus.where("status = ? AND comment_id = ?",1,params[:comment_id]).count 
   render :text=>@response ,:layout=>false
 end
 

end
