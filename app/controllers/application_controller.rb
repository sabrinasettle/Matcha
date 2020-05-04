class ApplicationController < ActionController::Base
    before_action :require_login

    include PublicActivity::StoreController

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user
    

    def user_avatar(user)
      if user.image.present?
        image_tag user.image_url :thumbnail
      else
        # Assuming you have a default.jpg in your assets folder
        image_tag 'default.jpg'
      end
    end

    # create random ip addresses
    # https://stackoverflow.com/questions/6115589/geocoder-how-to-test-locally-when-ip-is-127-0-0-1
    def request_ip
      if Rails.env.development? 
         response = HTTParty.get('http://api.hostip.info/get_html.php')
         ip = response.split("\n")
         ip.last.gsub /IP:\s+/, ''      
       else
         request.remote_ip
       end 
    end

    private

    def require_login
      unless current_user
        redirect_to login_url
      end
    end

      # Work on -- Avatar for profile needs to be set only at the start before the profile_created is true
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
