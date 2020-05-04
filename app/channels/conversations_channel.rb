class ConversationsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    current_user.conversations.each do |chat|
      stream_from "conversation: #{chat.id}"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end

  def send_message(data)
    # doesnt work for some reason
    # @convo = Conversation.find(data["conversation_id"])
    # message = @convo.messages.create(body: data["body"], user: current_user)
    # MessageRelayJob.perform_later(message)

    @chat = Conversation.find(data["conversation_id"])
    message = @chat.messages.create(body: data["body"], user: current_user)
    MessageRelayJob.perform_later(message)

    # @message = Message.new(body: data['message'])
    # if @message.save
    #   ActionCable.server.broadcast "conversation_channel", message: @message.body
    # end
  end
   
end
