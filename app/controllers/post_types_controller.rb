class PostTypesController < ApplicationController
#layout "global"
 before_filter :require_login
def index
     @post_types = PostType.all
     @post_types = PostType.paginate(:page => params[:page], :per_page => 2)
   end
 	  
   def new

   @post_type = PostType.new 
   end   
   
   def create
    @post_type = PostType.new(params[:post_type])
     if @post_type.save 
       redirect_to post_types_path
     end
   end

   def edit
     @post_type = PostType.find(params[:id])
   end
  
    def update
   @post_type = PostType.find(params[:id])

    
      if @post_type.update_attributes(params[:post_type])
       # format.html { redirect_to(@post_type, :notice => 'Post have successfully updated.') }
       redirect_to post_types_path
      else
          render :action => "edit"       
      end
    
  end
  
 	 def destroy
    @post_type = PostType.find(params[:id])
    @post_type.destroy 
    redirect_to post_types_path
 	 end
end
