# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $('#restart_server_btn').click (e) ->      
    $('#server_modal').modal('show')
    
    
  $('#perfom_restart').click (e) ->
    e.preventDefault()    
    
    $.ajax({      
      type: "GET",
      url: "/admin/restart_nginx_server"
      beforeSend: ->
        $('#control-zone').html(' Performing restart...
                      <img alt="Ajax-loader" src="/assets/ajax-loader.gif">')
    })
    setTimeout (->
      location.reload()
    ), 5000




    