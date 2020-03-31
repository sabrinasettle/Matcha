class PasswordsController < ApplicationController

    # https://gist.github.com/wendygwo/6d65db594151c7a9d459
    def create
        user = User.find_by_email(params[:email])
        user.send_password_reset if user
        #test puts user.email
        flash[:notice]="Email sent with password reset instructions."
        # if current_user
        #   redirect_to settings_path(user.name)
        # else
        #   redirect_to '/login'
        # end
    end

    def edit
        user = User.find_by(params[:password_reset_token])
    # puts user.password_reset_token #testing
    end

    def update
        user = User.find_by(params[:password_reset_token])
        # puts user.password_reset_token #testing
        if user.password_reset_sent_at < 1.hour.ago
            flash[:notice]="Password reset has expired"
        elsif user.password_reset_sent_at > 1.hour.ago
            user.update_attributes(user_params)
            # UserMailer.password_reset_finalized(user).deliver_now
            flash[:notice]="Password reset"
        # else
            # flash[:notice]=":P"
            # render :edit
        end
        redirect_to '/login'
    end

    def new
    end

    private
    
    def user_params
        params.require(:user).permit(:password, :password_confirmation)
    end
        
    
end
