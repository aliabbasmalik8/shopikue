App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#comments').append data['comment']
    # Called when there's incoming data on the websocket for this channel

  speak: (comment, user_id, product_id)->
    @perform 'speak', comment: comment, user_id: user_id, product_id: product_id

$(document).on 'keypress', '[data-behavior~=room_speaker]',(event) ->
  elem=$('#comment_body')
  user_id=elem.data('user_id')
  product_id=elem.data('product_id')
  if event.keyCode is 13 # return = send
    App.room.speak event.target.value, user_id, product_id
    event.target.value = ''
    event.preventDefault()