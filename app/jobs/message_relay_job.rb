class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message, c_u)
    if message.user_id == c_u
      c = 'message_sent'
    else
      c = 'message_received'
    end
    # Do something later
    ActionCable.server.broadcast "conversation: #{message.conversation.id}", {
      body: MessagesController.render(message), 
      # body: message.body, # this means that the html gets created and sent from the js in the conversations.coffee
      conversation_id: message.conversation.id,
      user: message.user.user_name,
      user_id: message.user.id,
      class: c
      # add avatar here as well??
    
      # Filter out who sent it client side??
      # user_id: message.user.id
      # stream_from "conversation: #{chat.id}"
  }
  end
end
