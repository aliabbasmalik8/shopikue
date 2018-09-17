App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log('-----------------------')
    console.log data
    if data['ancestry'] == null
      $('#comments').append data['comment']
    else
      $('#child_comment_'+ data['ancestry']).append data['comment']
    $('#child_form_'+data['ancestry']).remove()

   
    # Called when there's incoming data on the websocket for this channel

  speak: (comment, user_id, product_id, ancestry )->
    @perform 'speak', comment: comment, user_id: user_id, product_id: product_id, ancestry: ancestry

  update: (comment,comment_id, ancestry)->
    @perform 'update', comment: comment, comment_id: comment_id, ancestry: ancestry

$(document).on 'keypress', '[data-behavior~=room_speaker]',(event) ->
  if event.keyCode is 13 # return = send
    elem=$('#comment_body')
    user_id=elem.data('user_id')
    product_id=elem.data('product_id')
    ancestry= elem.data('ancestry')
    App.room.speak event.target.value, user_id, product_id, ancestry
    event.target.value = ''
    event.preventDefault()



$(document).on 'keypress', '[data-behavior~=update_comment]',(event) ->
  if event.keyCode is 13
    elem=$('#'+this.id)
    comment_id=elem.data('comment_id')
    ancestry=elem.data('ancestry')
    App.room.update event.target.value, comment_id, ancestry
    event.target.value = ''
    event.preventDefault()
    