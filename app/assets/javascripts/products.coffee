# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# $(document).on 'keypress', '[data-behavior~=search_bar]',(event) ->
#     if event.keyCode is 13 # return = send
#         $.ajax(
#             url: 'products/'+event.target.value+'/search'
#             beforeSend: (xhr) ->
#                 xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
#                 return
#             type: 'POST'
#             dataType: 'json'
#             data: search_value: event.target.value).done((data, textStatus, jqXHR) ->
#             console.log event.target.value
#             return
#         ).fail((jqXHR, textStatus, errorThrown) ->
#             console.log 'Error'
#             return
#         ).always (jqXHROrData, textStatus, jqXHROrErrorThrown) ->
#             return
#         return
#         event.target.value = ''
#         event.preventDefault()