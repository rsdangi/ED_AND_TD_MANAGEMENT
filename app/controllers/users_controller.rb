class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
 #layout 'global'

 before_filter :require_login ,:except => [:new,:create, :forgot_password, :send_reset_password_link, :update_password, :update_password_submit ,:is_user_exists]
 #before_save :generate_perishable_token
  def index
    @users = User.all
    @users = User.paginate(:page => params[:page], :per_page => 1)
     
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new    
    @user = User.new 
     respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
 
  end
  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user]) 
    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy   
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "User have successfully destroyed "
			@users = User.all
			render :partial => 'all_user', :layout => false
		else
			 redirect_to(:action=>'index')
		end
   # respond_to do |format|
    #  format.html { redirect_to(users_url) }
     # format.js   { render :nothing => true }  
  end
  

  def edit_password
    @user=User.find(current_user.id)    
  end
 	
  def change_password
       @user=User.find(current_user.id)
             actual_password = params[:password][:old]
             digest = "#{actual_password}#{@user.password_salt}"
             20.times { digest = Digest::SHA512.hexdigest(digest) }

   		if digest == @user.crypted_password
 		    if @user.update_attributes(params[:user])
			      flash[:notice] = 'Password successfully updated!'
			     redirect_to(edit_password_user_path)
		    else
			     render :action => "edit_password"
		    end     
		 else
			 flash[:notice] = 'incorrect old password'
			 redirect_to(edit_password_user_path)
		 end
    end

    def forgot_password
      
    end
    def send_reset_password_link
			@user = User.find_by_email(params[:user][:email])
			@perishable_token = Digest::MD5.hexdigest("#{Time.now}")
 			if @user.update_attributes(:perishable_token => @perishable_token)
				Notifier.deliver_password_reset_instructions(@user,request)
				flash[:notice] = "Instructions to reset your password have been emailed to you. " +  
				"Please check your email."  
				redirect_to root_url  
			else  
					flash[:notice] = "No user was found with that email address"  
					render :action => :forgot_password
			end  
    end
 
  def update_password
    @user = User.find_by_perishable_token(params[:perishable_token])     
	end
 
  def update_password_submit      
		 @user = User.find(params[:id])
  		if @user.update_attributes(params[:user])
				flash[:notice] = "Successfully reset password "
       redirect_to(users_path)
			else
				flash[:notice] = "There was a problem resetting your password."
				render :action => :update_password
			end
 	end
  
  def timeis

	 #render :text => 'ramswaroop', :layout => false
 
   @user = User.find(params[:id])  #from ajax to controller
   render  :layout => false
  end

  
 def is_user_exists
  #debugger
   enter_user = params[:enter_name]
   @user = User.Is_user_exists(enter_user)
   if @user 
     render :text=> 'user already exists' ,:layout => false     
   else
    # render :nothing => true ,:layout => false
   render :text=> 'user already not exists' ,:layout => false
   end
 end
 
end
