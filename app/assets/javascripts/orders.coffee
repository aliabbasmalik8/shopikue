# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
    $('input:radio').change ->
        $.ajax(
            url: 'add_rating'
            beforeSend: (xhr) ->
                xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
                return
            type: 'POST'
            dataType: 'json'
            data: rate: this.value).done((data, textStatus, jqXHR) ->
            console.log 'Success: ' + data
            return
        ).fail((jqXHR, textStatus, errorThrown) ->
            console.log 'Error'
            return
        ).always (jqXHROrData, textStatus, jqXHROrErrorThrown) ->
            return
    return
return