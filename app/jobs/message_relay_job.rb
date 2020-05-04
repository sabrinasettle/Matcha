class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    # Do something later
    ActionCable.server.broadcast "conversation: #{message.conversation.id}", {
    message: MessagesController.render(message), #It isnt there so thats fun
    # locals: { current_user: current_user and your other locals },
    conversation_id: message.conversation.id,
    # user_id: message.user.id
    # stream_from "conversation: #{chat.id}"
  }
  end
end
