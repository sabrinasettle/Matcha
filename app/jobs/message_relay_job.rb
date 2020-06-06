class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    # Do something later
    ActionCable.server.broadcast "conversation: #{message.conversation.id}", {
      message: MessagesController.render(message), 
      conversation_id: message.conversation.id
      # Filter out who sent it client side??
      # user_id: message.user.id
      # stream_from "conversation: #{chat.id}"
  }
  end
end
