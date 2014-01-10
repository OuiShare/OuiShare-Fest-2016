# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $('#restart_server_btn').click (e) ->
    e.preventDefault()    
    $.ajax({
      type: "GET",
      url: "/admin/restart_nginx_server"
    })
    setTimeout (->
      location.reload()
    ), 5000
    






    