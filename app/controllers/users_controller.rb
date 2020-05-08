class UsersController < ApplicationController
  skip_before_action :require_login

  # https://stackoverflow.com/questions/4982371/handling-unique-record-exceptions-in-a-controller
  # rescue_from ActiveRecord::RecordNotUnique, :with => :my_rescue_method
  before_action :user_params, only: [:create]

  def confirm_email
    if request.get?
      user = User.find_by(confirm_token: params[:token])
      if user.activate?
        flash[:notice] = "You have been activated and can now log in"
        redirect_to '/login'
      else
        flash[:warning] = "We could not activate you."
        redirect_to '/login'
      end
    end
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    # @user.setup_profile # Work on --to add profile when signing up TEST
    # @profile = Profile.new(profile_params) #trying to create the profile object on creation with basic information and just update it later
    if @user.save
      # puts "yay"
      # @profile.save
      
      UserMailer.registration_confirmation(@user).deliver_now
      flash[:notice]="Signup successful. Confirmation email has been sent"
      # session[:user_id] = user.id #I think for when it directly signed people in, could be wrong
      # redirect_to() #should go to the thanks for signing up page
      redirect_to '/login'

    elsif User.all.count > 0 && User.exists?(email: params[:user][:email])
      flash[:notice] = "Email already in use, please log in"
      redirect_to '/signup'
    else
      # flash[:notice] = @user.errors.full_messages #unless @profile.valid?
      # flash[:notice]="Please try again"
      redirect_to '/signup'
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password)
    end
end
