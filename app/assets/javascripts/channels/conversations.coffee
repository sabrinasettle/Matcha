App.conversations = App.cable.subscriptions.create "ConversationsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log(data)

    # works
    # active_room = $("[data-behavior='messages'][data-conversation-id='#{data.conversation_id}']").append(data.message)
        
    # Also works
    active_room = $("[data-behavior='messages'][data-conversation-id='#{data.conversation_id}']")
    if active_room.length > 0
      # if current user send it with a certain class to show on the left 
      # active_room.append("<li><div class=#{data.class}>#{data.user}<strong>#{data.body}</strong></div></li>")
        active_room.append(data.body)


    # if active_room.length > 0
    #   active_room.append(data.message)
    
    # Called when there's incoming data on the websocket for this channel
