App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if data['flag'] == 'create'
      App.room.render_comment data['comment_id'], data['product_id']

    else if data['flag'] == 'update'
      $('#child_form_'+data['comment_id']).remove()
      $('#comment_card_'+data['comment_id']).text(data['comment'])
    
    else if data['flag'] == 'destroy'
      $('#comment-card_of_'+data['comment_id']).remove();
      $('#child_comment_'+data['comment_id']).remove();
    else
      
  speak: (comment, user_id, product_id, ancestry )->
    @perform 'speak', comment: comment, user_id: user_id, product_id: product_id, ancestry: ancestry

  
  update: (comment,comment_id)->
    @perform 'update', comment: comment, comment_id: comment_id

  destroy: (comment_id)->
    @perform 'destroy',comment_id: comment_id

  render_comment: (comment_id, product_id)->
    $.ajax(
        url: '/comments/render_comment'
        beforeSend: (xhr) ->
            xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
            return
        type: 'POST'
        data: comment_id: comment_id, product_id: product_id).done((data, textStatus, jqXHR) ->
        return
    ).fail((jqXHR, textStatus, errorThrown) ->
        console.log 'Error'
        return
    ).always (jqXHROrData, textStatus, jqXHROrErrorThrown) ->
        return

$(document).on 'keypress', '[data-behavior~=room_speaker]',(event) ->
  if event.keyCode is 13 # return = send
    elem=$(this)
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
    App.room.update event.target.value, comment_id
    event.target.value = ''
    event.preventDefault()
    