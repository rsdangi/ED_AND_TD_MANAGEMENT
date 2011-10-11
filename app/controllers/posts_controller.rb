class PostsController < ApplicationController
 before_filter :require_login

  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 2) 
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create

    @post = Post.new(params[:post])
    respond_to do |format|
      if @post.save
        Usermailer.newemail(@post).deliver
        format.html { redirect_to(@post, :notice => 'Post was successfully created. and emails have send to all') }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
   
  end

   def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
 
 def search
  
  @search_title = params[:post][:search]
  @posts = Post.search(@search_title)
  #@posts = Post.paginate(:page => params[:page], :per_page => 2)
  render :action=>:index
 end

 def ajax_search
  @search_title = params[:search]
  @posts = Post.ajax_search(@search_title)
  render :partial => 'ajax_search', :layout => false
 end

 def post_sort
 sort = params[:sort]
 fields_value = params[:fields]
#  @posts = Post.post_sort(sort ,fields_value)
 @posts = Post.order("#{ fields_value+' '+ sort}").paginate(:page => params[:page], :per_page => 2)
  if sort =="asc"
   @sort_by = "desc"
  else
   @sort_by = "asc"
  end 
#  @posts = Post.paginate(:page => params[:page], :per_page => 2)
  render :action=>:index
 end

 def post_status_like
	   status	=	UserPostStatus.where("user_id = ? AND post_id = ?",params[:user_id],params[:id])
		 if status.blank?
        UserPostStatus.new(:status=>'1',:user_id=>params[:user_id],:post_id => params[:id])
 		 elsif status.first.status==1
     elsif status.first.status==0
             status = status.first
             status.update_attributes(:status=>'1')
     end
      redirect_to :action=>'index'
 end

 def post_status_unlike
   
   status	=	UserPostStatus.where("user_id = ? AND post_id = ?",params[:user_id],params[:id])
   if status.blank?
        UserPostStatus.new(:status=>'0',:user_id=>params[:user_id],:post_id => params[:id])
   elsif status.first.status==0
   elsif status.first.status==1
       status = status.first
       status.update_attributes(:status=>'0')
   end
   redirect_to :action=>'index'
 end

 def find_status
   @total = UserPostStatus.where("post_id= ? AND status = ? ",params[:id],1).count
 end

def ajax_post_status_like_unlike
 
  like_unlike_value = params[:Like_unlike_value]
   @post	=	UserPostStatus.where("user_id = ? AND post_id = ?" ,params[:user_id],params[:id])
    if like_unlike_value=="like"
				if @post.blank?
					@post = UserPostStatus.new(:status=>'1' , :user_id=> params[:user_id] , :post_id => params[:id])
				elsif @post.first.status==1
        elsif @post.first.status==0
                      @status = @post.first
                      @status.update_attributes(:status=>'1')
        end
    elsif like_unlike_value=="unlike"
           if @post.blank?
              @post = UserPostStatus.new(:status=>'0' , :user_id=> params[:user_id] , :post_id =>  params[:id])
              @post.save
           elsif @post.first.status==0
           elsif @post.first.status==1
                       @status = @post.first
                       @status.update_attributes(:status=>'0')
           end
      end 
	 @post= UserPostStatus.where("status = ? AND post_id = ?",1,params[:id]).count 
   render :text=>@post ,:layout=>false

end

end