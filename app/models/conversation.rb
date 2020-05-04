class Conversation < ApplicationRecord
    include PublicActivity::Common

    # https://www.nopio.com/blog/rails-real-time-chat-application-part-1/
    has_many :matches
    has_many :users, through: :matches
    has_many :messages, dependent: :destroy
    

    # scope :with_long_title, -> { where("LENGTH(title) > 20") }
    # scope :chat, ->(convo_id) { where("id: ?", convo_id)}

    # scope :with_long_title, ->(length) { where("LENGTH(title) > ?", length) }

    # Conversation.first.users.where(id: [1,2]).pluck(:conversation_id)



    
    def self.direct_message_for_users(id)

        # if conversation = Conversation.all
    #     user_ids = users.map(&:id)
    #     # if conversation = 
    # #     name = "DM:#{user_ids.join(":")}"
    # #     puts name
    #     if chat = 
    #       chat
    #     end
    # #     # else
    # #     #   # create a new chatroom
    # #     #   chatroom = new(name: name, direct_message: true)
    # #     #   chatroom.users = users
    # #     #   chatroom.save
    # #     #   chatroom
    # #     # end
    end

    def inverse_user_to(user)
        inverse = self.users.where.not(id: user.id)
        inverse.user_name
    end

    def get_conversation

    end

    # def self.shared_with(user)
    #             user_ids = users.map(&:id).sort

    #         # self.match.find(:all,
    #         #   :conditions => { :user_id => user }).pluck(:conversation_id)
            
          
    # end
    # def find_room(users)
    # find(params[:conversation_id])

    # def self.get_ids(array)
    #     ids = array.map(&:id).sort
    #     # puts ids

    # end

    validate :is_connected
  
    def is_connected
        #other way would be to include blocks.all as an object turned into an array
    #Check if the user is blocked or no, and write the logic
    #self.errors.add()
    end
    
end


