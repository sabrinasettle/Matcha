App.conversations = App.cable.subscriptions.create "ConversationsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # console.log(data)
    # active_room = $("[data-behavior='messages'][data-behavior='#{data.conversation_id}']").append(data.message)
    # if active_room.length > 0
    #   active_room.append(data.message)
    
    # Called when there's incoming data on the websocket for this channel
