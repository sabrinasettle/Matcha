class ConversationsController < ApplicationController
    # Work on -- Clean up this code to be DRY
    before_action :get_user
    before_action :get_convos

    def index 
    end

    # def create
    #     @opposed_user = User.find(params[:id])
    #     @id = Conversation.all.includes(:users).where(id: [@opposed_user, @user])
    #     redirect_to room_path(@id)
    # end
  
    def show
        puts @user.user_name
        @sender = current_user
        @p = params[:id]
        @chat = Conversation.find(params[:id])
        @reciever = User.find(@sender.matches.where(conversation_id: @chat.id).pluck(:inverse_user).first.to_i)
        @messages = @chat.messages.order(created_at: :desc).limit(100).reverse
        # p ActionCable.server.connections.length

        # aa = User.find_by_id(cookies.signed[:user_id])
        # puts aa.user_name

        # cookies.each do |cookie|
            # puts cookie
        # end
        # from the session contoller ==
        # cookies.signed[:user_id]


        # @id = @sender.matches.where(conversation_id: @chat.id).pluck(:inverse_user)
        # @reciever = User.find(id)

        # @reciever = find_by(params[:reciver_id])
        # @reciever = @chat.users.where.not(users: { id: @sender.id})
        # @id = nil
        # connections = @user.matches
        # unless connections.nil?
        #     @has_chats = 1
        #     # From there get the usernames of the other user connected to the convo
        #     matched_user_ids = Match.all.where.not(user_id: @user.id).where(conversation_id: connections).order(created_at: :desc).pluck(:user_id)
        #     @users = User.where(id: matched_user_ids).includes(:profile)
        #     # puts @users
        # end


        # @has_chats = 1
        # # could go in a separete method
        # # @opposite_user = User.find_by(params[id])
        # # @chat = Conversation.f
        # # unless @convo.messages.nil?

        # # Work on -- may not need the line below for the form to submit new Message
        # @new_message = Message.new
        # @curr_user = current_user.matches.find_by(conversation_id: @chat.id)
        # @other_user = User.find_by(id: @chat.other_user(@user.id))
            
    end


    def get_convos
        if @user.matches.any?
            @convos = @user.conversations.order(created_at: :desc)
            @inverse_users = User.where(user_name: @convos.includes(:users).where.not(users: { id: [@user.id]}).pluck(:user_name).uniq)
            has_chats = 1
        else
            has_chats = 0
        end
    end
    
    
    private
        def get_user
            # @user = User.find_by(user_name: params[:user_name])
            @user = current_user
        end
        def set_convo
            @convo = Conversation.find(params[:id])
        end
end
``