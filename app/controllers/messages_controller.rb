class MessagesController < ApplicationController
    before_action :set_convo
    
    def show
    end

    def create
        @message = @convo.messages.new(message_params)
        @message.user = current_user
        if @message.save
        #     # ConversationsChannel.broadcast_to @chat, @message
        #     # MessageRelayJob.perform_later(@message)
        #     # ActionCable.server.broadcast 'conversations',
        #     # message: @message.body,
        #     # user: @message.user.user_name
        #     # head :ok

            redirect_to room_path(@convo.id)
        end
        respond_to do |format|
            format.js
        end
    end

    private
        def set_convo
            @convo = Conversation.find_by(id: params[:id])

        end
  
        def message_params
            params.require(:message).permit(:body, :user_id)
        end
end
