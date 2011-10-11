class UsertypesController < ApplicationController
 before_filter :require_login
 def index
  @usertypes = Usertype.all
  @usertypes = Usertype.paginate(:page => params[:page], :per_page => 2)
 end
 
 def new
  @usertypes = Usertype.new
 end
 
 def create
  @usertypes = Usertype.new(params[:usertype])
   if @usertypes.save
    redirect_to usertypes_path
   else
    redirect_to new_usertype_path
  end
 end

 def edit
  @usertypes = Usertype.find(params[:id])
 end

 def update
  @usertypes = Usertype.find(params[:id])
  if @usertypes.update_attributes(params[:usertype])
    redirect_to usertypes_path
   else
    render :action => "edit"
  end  
 end
 
 def destroy
  @usertypes = Usertype.find(params[:id])
    @usertypes.destroy
    redirect_to usertypes_path
 end

end
