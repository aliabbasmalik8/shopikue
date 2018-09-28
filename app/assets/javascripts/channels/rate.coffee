App.rate = App.cable.subscriptions.create "RateChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    i = 1
    count = data.product_rating
    while i<= count
      $('#rate_for_product_'+data.product_id).find('#s_'+i).removeClass('hidden')
      i = i + 1
    while i<= 5
      $('#rate_for_product_'+data.product_id).find('#s_'+i).addClass('hidden')
      i = i + 1
    # Called when there's incoming data on the websocket for this channel

  speak: (data)->
    @perform 'speak', data[0]
