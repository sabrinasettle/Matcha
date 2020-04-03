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
  end

  private
  
    def find_user
      @user = User.find_by(user_name: params[:user_name])
    end
end
