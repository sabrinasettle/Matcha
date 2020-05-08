class PasswordsController < ApplicationController
    skip_before_action :require_login

    def new
        @user = nil
    end

    def create
        @user = User.find_by(email: params[:email])
        @user.send_password_reset if @user
        flash[:notice]="Email sent with password reset instructions."
        if current_user
          redirect_to settings_path(user.user_name)
        else
          redirect_to '/login'
        end
    end

    def edit
        @user = User.find_by(password_reset_token: params[:token])
    end

    def update
        @user = User.find_by(id: params[:id])
        if params[:password_confirmation] == params[:password]
            if @user.password_reset_sent_at < 1.hour.ago
                flash[:notice]="Password reset has expired"
            elsif @user.password_reset_sent_at > 1.hour.ago
                if @user.update_attributes(user_params)
                    #Work on -- TEST THIS
                    @user.update_attribute(:password_reset_sent_at, nil)
                    @user.update_attribute(:password_reset_token, nil)
                    # Send email about password change
                    UserMailer.password_reset_finalized(@user).deliver_now
                    flash[:notice]="Password reset"
                end
            end
            redirect_to '/login'
        else
            flash[:alert]="Password and Password confirmation must match"
        end
    end

    private
    
    def user_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end
