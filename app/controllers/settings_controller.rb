class SettingsController < ApplicationController
  # before_action :is_logged_in
  before_action :find_user, only: [:edit, :edit_user, :edit_password, :activity, :update, :update_password]
  before_action :load_activity, only: [:edit, :activity]
  
  def edit
      @activities = PublicActivity::Activity.all.order(created_at: :DESC).where(owner_id: current_user.id, owner_type: "User").or(PublicActivity::Activity.all.order(created_at: :DESC).where(recipient_id: current_user, owner_type: "User"))
  end

  def edit_user
    respond_to do |format|
      format.js {}
    end
  end

  def edit_password
    respond_to do |format|
      format.js {}
    end
  end

  def activity
    
    @activities = PublicActivity::Activity.all.order(created_at: :DESC)
    respond_to do |format|
      format.js {}
    end
  end

  def update
    @user.skip_validations = true
    if @user.update_attributes!(user_params)
      #updates the profiles first_name value as well
      @user.profile.update_attribute(:first_name, @user.first_name)
      flash[:notice] = "Profile changed successfully!"
      redirect_to settings_path(@user.user_name)
    else
      flash[:alert] = "Profile not updated, try again"
      redirect_to edit_user_path(@user.user_name)
      #alert somehting went wrong!
    end
  end

  def update_password
    # https://stackoverflow.com/questions/32674502/ruby-on-rails-change-update-password-with-modal-on-profile-page-validate-old-pas
    new_password = params[:user][:new_password]
    if @user.authenticate(params[:user][:current_password])
      puts "yay it authenicated"
      if @user.update_attribute(:password, new_password)
        flash[:notice] = "Password changed successfully!"
      end
    else
      # Work on -- Alert didnt show up on page
      flash[:alert] = "Password changed successfully!"
    end
    redirect_to settings_path(@user.user_name)
  end

  # Work on -- for the reset page -- yay!
  def reset_password

  end

  private
    # For in General
    def find_user
      @user = User.find_by(user_name: params[:user_name])
    end

    # For password resetting
    def find_for_reset
      @user = User.find_by(email: params[:email])
    end

    # For activity and edit methods/pages
    def load_activity


    end

    def user_params

      # {:book_rooms => [:checked_out]}
      # params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password, {:profile => [:id, :age, :bio, :gender, :sexual_preferences, :user_name, :avatar, :postal_code]})
      params.require(:user).permit(:first_name, :last_name, :user_name, :email)
    end   
    
    # for finding like if needed (Ordered by is of interest here)
    # users = User.where(name: 'David', occupation: 'Code Artist').order(created_at: :desc)
end
