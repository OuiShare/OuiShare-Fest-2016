# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $('#link_contact_modal').click (e) ->
    $('#contact_modal').modal('toggle')

  $("a[href^=\"#anc\"]").on "click", (e) ->
    e.preventDefault()
    target = @hash
    $target = $(target)
    $("html, body").stop().animate
      scrollTop: $target.offset().top
    , 900, "swing", ->
      window.location.hash = target

  $("#btn_showspeakers_down").click ->
    $("#allspeakers").slideDown "slow"
    $("#btn_showspeakers_down").hide()
    # $("#btn_showspeakers_up").show()

  # $("#btn_showspeakers_up").click ->
  #   $("#allspeakers").slideUp "slow"
  #   $("#btn_showspeakers_up").hide()
  #   $("#btn_showspeakers_down").show()


