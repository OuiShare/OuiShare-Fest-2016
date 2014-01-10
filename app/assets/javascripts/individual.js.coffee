# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

goToByScroll = (id) ->   
  $('html,body').animate({
    scrollTop: $("#"+id).offset().top
    },
    'slow')

# check_file_size = (size) ->
#   if this.files[0].size > 9000000
#     $('#file_attachment_error').html('File too big, please select a file < 9 MO or contact the developpers to upgrade the limit')
#     $('#file_attachment_error').css('color', 'red')

display_error_on_element = (elements, validation_status, message) ->
  validation_result = {}
  validation_status = false  
  for element in elements
    element_class = $("."+element)
    if element_class.closest('.form-error-highlight').length == 0
      element_class.wrap("<div class='form-error-highlight' id = '" + element + "_error_highlight'></div>")
      element_class.prepend("<div class= 'form-error-message'>" + message + "</div>")
  

  validation_result["status"] = validation_status
  validation_result["last_anchor"] = element + "_error_highlight"
  return validation_result

remove_error_display_on_element = (elements) ->
  for element in elements
    element_class = $("."+element)
    if element_class.closest('.form-error-highlight').length > 0
      element_class.closest('.form-error-highlight').find(".form-error-message").remove()
      element_class.unwrap()

validate_form = ->  
  validators = 
    all_checkbox_checked : [false, ["individual-type-checkboxes"], "You must select at least one group"]
    fname_lname_company_typed : [false, ["individual-fname-zone","individual-lname-zone", "individual-company-zone"],"You must enter either a first name, last name or a company"]
    # filesize_checked : [false, ["file_attachment_error"],'File too big, please select a file < 9 MO or contact the developpers to upgrade the limit']
    # lname_typed : [false, "individual-lname-zone","You must enter either a first name, last name or a company"]
    # email_typed : [false, ["individual-email-zone"],"You must enter an email"]
    # company_typed : [false, "individual-company-zone","You must enter either a first name, last name or a company"]
  validation_status = {}
  # fname_lname_company_missing = true
  validation_status["status"] = true

  $(".individual-type-checkbox").each ->
    if $(this).prop("checked")
      validators.all_checkbox_checked[0] = true

  #if $("#individual_email").val().length > 0
  #  validators.email_typed[0] = true

  if $("#individual_first_name").val().length > 0 
    validators.fname_lname_company_typed[0] = true
    # fname_lname_company_missing = false

  if $("#individual_last_name").val().length > 0
    validators.fname_lname_company_typed[0] = true
    # fname_lname_company_missing = false

  if $("#individual_company_name").val().length > 0
    validators.fname_lname_company_typed[0] = true
    # fname_lname_company_missing = false



  $.each(validators, (key, value) ->   

    if !value[0] 
      validation_status = display_error_on_element(value[1], validation_status["status"], value[2]) 
    else
      remove_error_display_on_element(value[1])
  )   
  console.log validation_status
  if validation_status["last_anchor"]
    goToByScroll(validation_status["last_anchor"])

  return validation_status["status"]


$(document).ready ->
  $("#save_individual_button").click (e) ->
    e.preventDefault()   
    if result = validate_form()  
      console.log result
      $("#save_individual_button").closest('form').submit()

  $("#individual_attachment").change (e) ->

    if this.files[0].size > 9000000
      $('#file_attachment_error').html('File too big, please select a file < 9 MO or contact the developpers to upgrade the limit')
      $('#file_attachment_error').css('color', 'red')
      if !$('#save_individual_button').is('[disabled=disabled]')
        $('#save_individual_button').attr('disabled', 'disabled')
    else
      $('#file_attachment_error').html('')
      if $('#save_individual_button').is('[disabled=disabled]')        
        $('#save_individual_button').prop('disabled', '')