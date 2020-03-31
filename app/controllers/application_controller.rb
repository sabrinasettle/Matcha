class ApplicationController < ActionController::Base
  
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      end
      helper_method :current_user
    
      # def current_user?(user)
        # user == current_user
      # end
    
      def logged_in?
        !current_user.nil?
        redirect_to '/signup'
      end

      # def after_sign_in_path_for(resource)
      #   unless current_user.profile.nil?
      #     main_path 
      #   else
      #     flash[:alert] = "Please complete your profile"
      #     show_profile_path
      #   end
      # end

      # https://stackoverflow.com/questions/49508846/how-can-i-set-a-default-image-for-user-in-rails
      #   def avatar_for(user)
      #     @avatar = user.avatar
      #     if @avatar.empty?
      #         @avatar_user = image_tag("user.png", alt: user.name)
      #     else
      #         @avatar_user = image_tag(@avatar.url, alt: user.name)
      #     end
      #     return @avatar_user
      # end


      def user_avatar(user)
        if user.image.present?
          image_tag user.image_url :thumbnail
        else
          # Assuming you have a default.jpg in your assets folder
          image_tag 'default.jpg'
        end
      end

      # http://hankstoever.com/posts/11-Pro-Tips-for-Using-Geocoder-with-Rails
      # def location
      #   if params[:location].blank?
      #     if Rails.env.test? || Rails.env.development?
      #       @location ||= Geocoder.search("50.78.167.161").first
      #     else
      #       @location ||= request.location
      #     end
      #   else
      #     params[:location].each {|l| l = l.to_i } if params[:location].is_a? Array
      #     @location ||= Geocoder.search(params[:location]).first
      #     @location
      #   end
      # end
end
