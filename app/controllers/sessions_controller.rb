class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_user_name(params[:user_name])
    # @user = User.where(user_name: params[:user_name])
    puts user.user_name
    if user && user.authenticate(params[:password])
      if user.email_confirmed
        session[:user_id] = user.id
        user.update(online: true)
        # https://stackoverflow.com/questions/17480487/rails-4-session-expiry
        # session[:expires_at] = Time.current + 24.hours
        flash[:notice]="Login successful"
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
    user = User.find_by(id: current_user.id)
    user.update(online: false)
    session[:user_id] = nil
    flash[:notice]="Logged Out"
    redirect_to '/login'
  end
end
