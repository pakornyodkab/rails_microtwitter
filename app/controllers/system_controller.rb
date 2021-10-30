class SystemController < ApplicationController
  before_action :logged_in ,only: %i[feed new_post profile createfollow createpost destroyfollow]

  def register
    @user = User.new
  end

  def feed
    user_id = session[:user_id]
    @user = User.find(user_id)
    @post = @user.get_feed_post(user_id)
    
  end

  def new_post
    @post = Post.new
  end

  def profile
    user_name = params[:name]
    @user = User.find_by(name:user_name)

    if (@user.nil?)
      respond_to do |format|
        format.html { redirect_to feed_path ,alert:"Profile name is wrong" }
        format.json { head :no_content }
      end
    end


  end

  def main
    session[:user_id] = nil
  end

  def userlogin
    emails = params[:email]
    password = params[:password]
    @user = User.find_by(email:emails)
    if (!@user.nil?)
      if (@user.authenticate(password))
        session[:user_id] = @user.id
        respond_to do |format|
          format.html { redirect_to feed_path }
          format.json { head :no_content }
        end
      else
        session[:user_id] = nil
        respond_to do |format|
          format.html { redirect_to main_path, alert: "Wrong password" }
          format.json { head :no_content }
        end
      end
    else
      session[:user_id] = nil
      respond_to do |format|
        format.html { redirect_to main_path, alert: "Wrong email " }
        format.json { head :no_content }
      end
    end

  end

  def create
    u = user_params
    @user = User.new(name:u[:name] ,email:u[:email],password:u[:password])

    password = u[:password]
    confirm_password = u[:confirm_password]
    
    @correctpass = true

    if(!confirm_password.eql?(password))
      @correctpass = false
    end

    @alertword = ""

    respond_to do |format|
      if (@correctpass && @user.save )
        format.html { redirect_to main_path, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        @alertword = (@correctpass)? "" : "Password and confirm password are not equal"
        @user.valid?
        format.html { render :register, status: :unprocessable_entity  }
        format.json { render json: @user.errors, status: :unprocessable_entity } 
      end
    end
  end

  def createfollow
    follower_id = params[:follower_id]
    followee_id = params[:followee_id]
    @follow = Follow.new(follower_id:follower_id,followee_id:followee_id)

    respond_to do |format|
      if @follow.save
        #profile = User.find(followee_id)
        #profilename = profile.name
        format.html { redirect_to feed_path, notice: "Follow was successfully created." }
        format.json { render :show, status: :created, location: @follow }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @follow.errors, status: :unprocessable_entity }
      end
    end
  end

  def createpost
    post = post_params
    msg = post[:msg]
    user_id = session[:user_id]
    @post = Post.new(msg:msg ,user_id:user_id)

    respond_to do |format|
      if @post.save
        format.html { redirect_to feed_path, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new_post, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroyfollow
    follower_id = params[:follower_id]
    followee_id = params[:followee_id]
    #profile = User.find(followee_id)
    #profilename = profile.name

    @follow = Follow.find_by(follower_id:follower_id,followee_id:followee_id)
    @follow.destroy

    respond_to do |format|
      format.html { redirect_to feed_path, notice: "Follow was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def createlike
    post_id = params[:post_id]
    user_id = params[:user_id]
    @like = Like.new(post_id:post_id ,user_id:user_id)

    respond_to do |format|
      if @like.save
        format.html { redirect_to request.referrer, notice: "Like was successfully created." }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroylike
    post_id = params[:post_id]
    user_id = params[:user_id]
    @like = Like.find_by(post_id:post_id ,user_id:user_id)
    @like.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: "Like was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email ,:password ,:confirm_password)
    end

    def logged_in
      if (session[:user_id])
        return true
      else
        respond_to do |format|
          format.html { redirect_to main_path, alert: "Please Login " }
          format.json { head :no_content }
        end
      end
    end

    def post_params
      params.require(:post).permit(:msg)
    end
end
