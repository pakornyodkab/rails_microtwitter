class SystemController < ApplicationController
  before_action :logged_in ,only: %i[feed new_post profile]

  def register
    @user = User.new
  end

  def feed
    user_id = session[:user_id]
    @user = User.find(user_id)
    
  end

  def new_post
  end

  def profile
    user_name = params[:name]
    @user = User.find_by(name:user_name)
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

    correctpass = true

    if(confirm_password != password)
      correctpass = false
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to main_path, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :register, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity } 
      end
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
end
