https://iridakos.com/programming/2019/04/04/creating-chat-application-rails-websockets

$(function() {
    $('[data-channel-subscribe="room"]').each(function(index, element) {
      var $element = $(element),
          room_id = $element.data('room-id')
          messageTemplate = $('[data-role="message-template"]');
  
      $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000)        
  
      App.cable.subscriptions.create(
        {
          channel: "ConversationsChannel",
          chat: room_id
        },
        {
          received: function(data) {
            var content = messageTemplate.children().clone(true, true);
            content.find('[data-role="user-avatar"]').attr('src', data.user_avatar_url);
            content.find('[data-role="message-text"]').text(data.message);
            content.find('[data-role="message-date"]').text(data.updated_at);
            $element.append(content);
            $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000);
          }
        }
      );
    });
  });