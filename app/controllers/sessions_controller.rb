class SessionsController < ApplicationController
  skip_before_action :require_login

  before_action :find_user, only: [:destroy]

  def new
  end

  def create
    @user = User.find_by(user_name: params[:user_name])
    if @user && @user.authenticate(params[:password])
      puts "Authorized to continue"
      if @user.email_confirmed == true
        @user.update_attribute(:online, true)
        puts "is online"
        flash[:notice]="Login successful"
        puts @user.id # TESTING
        session[:user_id] = @user.id
        puts session.id
        cookies.signed[:user_id] = current_user.id
        # https://stackoverflow.com/questions/17480487/rails-4-session-expiry
        # session[:expires_at] = Time.current + 24.hours
        redirect_to '/main'
      else
        flash[:notice]="Your account is not activated yet!"
        redirect_to '/login'
      end
    else
      flash[:notice]="Invalid Username or Password"
      redirect_to '/login'
    end
  end

  def destroy
    # Work on -- clean this up
    @user.update_attribute(:online, false)
    @user.update_attribute(:last_online, DateTime.now)
    session[:user_id] = nil
    cookies.signed[:user_id] = nil
    flash[:notice]="Logged Out"
    redirect_to '/login'
  end

  private
  
    def find_user
      @user = User.find_by(id: current_user.id)
    end
end
