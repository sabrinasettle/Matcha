App.conversations = App.cable.subscriptions.create "ConversationsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log(data)

    # OF INTEREST

    # https://www.nopio.com/blog/rails-real-time-chat-application-part-1/


    # $(function() {
    #   var scrollToArea = function(button, area) { ... };
        
    # });

  # $('#textdiv').append('The longest string ever parsed goes here.');
  # scroll_to_bottom($('#textdiv'));

    # works
    # active_room = $("[data-behavior='messages'][data-conversation-id='#{data.conversation_id}']").append(data.message)
        
    # Also works

    active_room = $("[data-behavior='messages'][data-conversation-id='#{data.conversation_id}']")
    if active_room.length > 0
      # if current user send it with a certain class to show on the left 
      # active_room.append("<li><div class=#{data.class}>#{data.user}<strong>#{data.body}</strong></div></li>")
        active_room.animate({ scrollTop: active_room.height()-active_room.height() }, 500); #animate({scrollTop: active_room.height}, 500);
        # .animate({ scrollTop: active_room.height()-active_room.height() }, 500);
        active_room.append(data.body)
        active_room.animate { scrollTop: active_room.prop('scrollHeight') }, 1000
        # scroll_to_bottom(active_room);


    # if active_room.length > 0
    #   active_room.append(data.message)
    
    # Called when there's incoming data on the websocket for this channel



# $ ->
#   $('[data-channel-subscribe="room"]').each (index, element) ->
#     $element = $(element)
#     room_id = $element.data('room-id')
#     messageTemplate = $('[data-role="message-template"]')
#     $element.animate { scrollTop: $element.prop('scrollHeight') }, 1000
#     App.cable.subscriptions.create {
#       channel: 'ConversationsChannel'
#       chat: room_id
#     }, received: (data) ->
#       content = messageTemplate.children().clone(true, true)
#       content.find('[data-role="user-avatar"]').attr 'src', data.user_avatar_url
#       content.find('[data-role="message-text"]').text data.message
#       content.find('[data-role="message-date"]').text data.updated_at
#       $element.append content
#       $element.animate { scrollTop: $element.prop('scrollHeight') }, 1000
#       return
#     return
#   return