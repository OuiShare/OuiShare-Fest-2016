# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
toggle_class = (element,class_name) ->
  if $(element).hasClass class_name
    $(element).removeClass class_name
  else
    $(element).addClass class_name

$(document).ready ->

  $('.special_tooltip').tooltip()

  if window.location.search.replace('?', '') == 'tickets'
    $tabs = $(".tabbable li")
    $tabs.filter(".active").next("li").find("a[data-toggle=\"tab\"]").tab "show"
    $("html, body").animate({ scrollTop: 0 }, 600)
    $('#calendar').fullCalendar('render')  

  if $('#visit_modal').length > 0
    setTimeout (->
      $('#visit_modal').modal('show')
      return
    ), 7000

  $('.get-involved-link').click (e) ->
    $('#visit_modal').modal('hide')

  $('#link_contact_modal').click (e) ->
    $('#contact_modal').modal('toggle')

  # Home Page
  $("a[href^=\"#_\"]").on "click", (e) ->
    e.preventDefault()
    target = @hash
    $target = $(target)    
    scroll_position = $target.offset().top - $('.navbar').height()-10
    $('html,body').animate
      scrollTop: scroll_position
      ,'slow', "swing"       
    # $("html, body").stop().animate
    #   scrollTop: scroll_position
    # , 900, "swing", ->
    #   window.location.hash = target

  # Page About
  $("a[href^=\"about#_about_\"]").on "click", (e) ->
    e.preventDefault()
    target = @hash
    if $(this).pathname == "/about"
      $target = $(target)    
      scroll_position = $target.offset().top - $('.navbar').height()-10
      $('html,body').animate
        scrollTop: scroll_position
        ,'slow', "swing"       
    else
      # window.location.href = window.location.hostname + target
      # console.log $(this).attr('href')
      window.location = $(this).attr('href')


  $("#btn_showspeakers_down").click ->
    $("#btn_showspeakers_down").hide()
    $("#allspeakers").slideDown "slow"
    toggle_class("#btn_showspeakers_up", "hide")
    

  $("#btn_showspeakers_up").click ->
    toggle_class("#btn_showspeakers_up", "hide")    
    $("#allspeakers").slideUp "slow"
    $('html,body').animate({
    scrollTop: $("#_speakers").offset().top - $('.navbar').height()
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
    scrollTop: $("#_team").offset().top - $('.navbar').height()
    },
    'slow') 
    $("#btn_team_members_down").show()   
    
  $("#btn_attendees_down").click ->
    $("#btn_attendees_down").hide()
    $("#allattendees").slideDown "slow"
    $("#btn_attendees_up").show()

  $("#btn_attendees_up").click ->
    $("#btn_attendees_up").hide()
    $("#allattendees").slideUp "slow"
    $("#btn_attendees_down").show()
    $('html,body').animate({
    scrollTop: $(".who-s-coming-title").offset().top - 77
    },
    'slow')

  # Chargement du carousel
  $(".carousel").carousel()

  
  #Slideshow
  
  $(".banner").revolution
    delay: 4000
    startwidth: 1040
    startheight: 600
    onHoverStop: "off" # Stop Banner Timet at Hover on Slide on/off
    thumbWidth: 100 # Thumb With and Height and Amount (only if navigation Tyope set to thumb !)
    thumbHeight: 50
    thumbAmount: 3
    hideThumbs: 0
    navigationType: "bullet" # bullet, thumb, none
    navigationArrows: "none" # nexttobullets, solo (old name verticalcentered), none
    navigationStyle: "round-old" # round,square,navbar,round-old,square-old,navbar-old, or any from the list in the docu (choose between 50+ different item), custom
    navigationHAlign: "center" # Vertical Align top,center,bottom
    navigationVAlign: "bottom" # Horizontal Align left,center,right
    navigationHOffset: -419
    navigationVOffset: 150
    touchenabled: "on" # Enable Swipe Function : on/off
    stopAtSlide: -1 # Stop Timer if Slide "x" has been Reached. If stopAfterLoops set to 0, then it stops already in the first Loop at slide X which defined. -1 means do not stop at any slide. stopAfterLoops has no sinn in this case.
    stopAfterLoops: -1 # Stop Timer if All slides has been played "x" times. IT will stop at THe slide which is defined via stopAtSlide:x, if set to -1 slide never stop automatic
    hideCaptionAtLimit: 0 # It Defines if a caption should be shown under a Screen Resolution ( Basod on The Width of Browser)
    hideAllCaptionAtLilmit: 0 # Hide all The Captions if Width of Browser is less then this value
    hideSliderAtLimit: 0 # Hide the whole slider, and stop also functions if Width of Browser is less than this value
    fullWidth: "on"
    shadow: 0 #0 = no Shadow, 1,2,3 = 3 Different Art of Shadows -  (No Shadow in Fullwidth Version !)


  init_map = ->
    myOptions =
      zoom: 16
      center: new google.maps.LatLng(48.895322, 2.392119)
      mapTypeId: google.maps.MapTypeId.ROADMAP
      scrollwheel: false
      navigationControl: false
      mapTypeControl: false
      scaleControl: false
      draggable: false

    map = new google.maps.Map(document.getElementById("gmap_canvas"), myOptions)
    marker = new google.maps.Marker(
      map: map
      position: new google.maps.LatLng(48.895322, 2.392119)
    )
    infowindow = new google.maps.InfoWindow(content: "<div style='position:relative;line-height:1.34;overflow:hidden;white-space:nowrap;display:block;'><div style='margin-bottom:2px;font-weight:500;'>Ouishare Fest</div><span>Cabaret Sauvage <br>  Paris</span></div>")
    google.maps.event.addListener marker, "click", ->
      infowindow.open map, marker
      return

    infowindow.open map, marker
    return
  google.maps.event.addDomListener window, "load", init_map

