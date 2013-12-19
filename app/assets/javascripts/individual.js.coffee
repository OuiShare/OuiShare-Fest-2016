# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

goToByScroll = (id) ->   
  $('html,body').animate({
    scrollTop: $("#"+id).offset().top
    },
    'slow')

display_error_on_element = (element, validation_status, message) ->
  validation_result = {}
  validation_status = false  
  element_class = $("."+element)
  if element_class.closest('.form-error-highlight').length == 0
    element_class.wrap("<div class='form-error-highlight' id = '" + element + "_error_highlight'></div>")
    element_class.prepend("<div class= 'form-error-message'>" + message + "</div>")
  

  validation_result["status"] = validation_status
  validation_result["last_anchor"] = element + "_error_highlight"
  return validation_result

remove_error_display_on_element = (element) ->
  element_class = $("."+element)
  if element_class.closest('.form-error-highlight').length > 0
    element_class.closest('.form-error-highlight').find(".form-error-message").remove()
    element_class.unwrap()

validate_form = ->  
  validators = 
    all_checkbox_checked : [false, "individual-type-checkboxes", "You must select at least one group"]
    fname_typed : [false, "individual-fname-zone","You must enter a first name"]
    lname_typed : [false, "individual-lname-zone","You must enter a last name"]
    email_typed : [false, "individual-email-zone","You must enter an email"]
  
  validation_status = {}
  validation_status["status"] = true

  $(".individual-type-checkbox").each ->
    if $(this).prop("checked")
      validators.all_checkbox_checked[0] = true

  if $("#individual_email").val().length > 0
    validators.email_typed[0] = true

  if $("#individual_first_name").val().length > 0
    validators.fname_typed[0] = true

  if $("#individual_last_name").val().length > 0
    validators.lname_typed[0] = true

  $.each(validators, (key, value) ->
    if !value[0] 
      validation_status = display_error_on_element(value[1], validation_status["status"], value[2]) 
    else
      remove_error_display_on_element(value[1])
  )   
  
  if validation_status["last_anchor"]
    goToByScroll(validation_status["last_anchor"])

  return validation_status["status"]


$(document).ready ->
  $("#save_individual_button").click (e) ->
    e.preventDefault()   
    if validate_form()         
      $("#save_individual_button").closest('form').submit()