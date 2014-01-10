# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
toggle_class = (element,class_name) ->
  if $(element).hasClass class_name
    $(element).removeClass class_name
  else
    $(element).addClass class_name

$(document).ready ->
  $('#link_contact_modal').click (e) ->
    $('#contact_modal').modal('toggle')

  $("a[href^=\"#anc\"]").on "click", (e) ->
    e.preventDefault()
    target = @hash
    $target = $(target)    
    scroll_position = $target.offset().top - $('.navbar').height()-10  
    $("html, body").stop().animate
      scrollTop: scroll_position
    , 900, "swing", ->
      window.location.hash = target

  $("#btn_showspeakers_down").click ->
    $("#btn_showspeakers_down").hide()
    $("#allspeakers").slideDown "slow"
    toggle_class("#btn_showspeakers_up", "hide")
    

  $("#btn_showspeakers_up").click ->
    toggle_class("#btn_showspeakers_up", "hide")    
    $("#allspeakers").slideUp "slow"
    $('html,body').animate({
    scrollTop: $("#anc_speakers").offset().top - $('.navbar').height()
    },
    'slow') 
    $("#btn_showspeakers_down").show()

  $("#btn_team_members_down").click ->
    $("#btn_team_members_down").hide()
    $("#allteam_members").slideDown "slow"
    toggle_class("#btn_team_members_up", "hide")
    

  $("#btn_team_members_up").click ->
    toggle_class("#btn_team_members_up", "hide")    
    $("#allteam_members").slideUp "slow"
    $('html,body').animate({
    scrollTop: $("#anc_team").offset().top - $('.navbar').height()
    },
    'slow') 
    $("#btn_team_members_down").show()   
    
  $("#btn_attendees_down").click ->
    $("#btn_attendees_down").hide()
    $("#allattendees").slideDown "slow"
    toggle_class("#btn_attendees_up", "hide")    

  $("#btn_attendees_up").click ->
    toggle_class("#btn_attendees_up", "hide")    
    $("#allattendees").slideUp "slow"
    $('html,body').animate({
    scrollTop: $("#attendees_list").offset().top
    },
    'slow') 
    $("#btn_attendees_down").show()



