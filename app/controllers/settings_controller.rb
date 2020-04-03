class SettingsController < ApplicationController

  before_action :find_user, only: [:edit, :update]

  def edit
    @flag = params[:flag]
    respond_to do |format|
      format.html {}
      case
      when @flag == '1'
        format.js { render :edituser, layout: false}
      when @flag == '2'
        format.js { render :editpassword, layout: false}
      when @flag == '3'
        format.js { render :views_and_likes, layout: false}
      end
    end
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to '/'
    end
  end

  private
  
    def find_user
      @user = User.find_by(user_name: params[:user_name])
    end

    def user_params

      # {:book_rooms => [:checked_out]}
      # params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password, {:profile => [:id, :age, :bio, :gender, :sexual_preferences, :user_name, :avatar, :postal_code]})
      params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password, profile_attributes: [:id, :age, :bio, :gender, :sexual_preferences, :user_name, :avatar, :postal_code])
    end
end
