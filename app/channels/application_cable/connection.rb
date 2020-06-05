module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags "ActionCable", "User #{current_user.user_name}"
      # puts "HEY"
    end

    private
    def find_verified_user
        puts "hey hey hey"
        # verified_user = User.find_by_id(cookies.signed[:user_id])
        verified_user = env["warden"].user
        if verified_user #= User.find(session[:user_id])
          verified_user
        else
          reject_unauthorized_connection
        end
      end
  end
end
