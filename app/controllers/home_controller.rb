class HomeController < ApplicationController

  # For negative captcha
  before_filter :contact_captcha, :only => [:contact, :contact_email]
  
  require 'eventbrite-client'
  
  def index    

    if IndividualType.find_by_title('Team')
      @team_members = IndividualType.find_by_title('Team').get_members
    end
    if IndividualType.find_by_title('Speakers')

      @speakers = IndividualType.find_by_title('Speakers').get_members
      if ENV["DISPLAYED_SPEAKERS"].to_i > @speakers.count
        displayed_speakers_number = @speakers.count
      else
        displayed_speakers_number = ENV["DISPLAYED_SPEAKERS"].to_i
      end

      @displayed_speakers = @speakers.first(displayed_speakers_number)
      @hidden_speakers = @speakers.last(@speakers.count - displayed_speakers_number)
    end

    eventbrite_instance = connect_to_eventbrite()
    begin
      @ouishare_fest_attendees = eventbrite_instance.event_list_attendees({ "id" => ENV["EVENTBRITE_EVENT_ID"] })
    rescue
      @ouishare_fest_attendees = nil
    end
  
  end

  def faq
  end

  def site_off
  end

  def contact
    # Set marker options for contact map
    @lng = ENV['COMPANY_LONG']
    @lat = ENV['COMPANY_LAT']

    
    @description = render_to_string(:partial => "/home/partials/contact_infowindow").squish.gsub('"','\'')

    @picture = "assets/markers/marker_002.png"
    @title = "Title"
    @width = "32"
    @height = "32"

    @marker = '[{"description":"' + @description + '","picture":"' + @picture + '","width":' + @width + ',"height":' + @height + ',"title":"' + @title + '","lng":' + @lng + ', "lat": ' + @lat + '}]'

  end

  def contact_email()  
    # Decrypted params are stored in @contact_captcha.values
    name = @contact_captcha.values[:name]
    email = @contact_captcha.values[:email]
    message = @contact_captcha.values[:message]
    
    AdminMailer.contact_staff_email(message, name, email)

    # @contact_captcha.valid? will return false if a bot submitted the form
    if @contact_captcha.valid?
      redirect_to root_path, :notice => 'Your mail has been sent to the staff, we will respond to you as soon as possible'
    else
      # @contact_captcha.error will explain what went wrong
      flash[:alert] = @contact_captcha.error if @contact_captcha.error 
      render :action => :contact
    end
  end

private
  def contact_captcha()
    @contact_captcha = NegativeCaptcha.new(
      # A secret key entered in environment.rb. 'rake secret' will give you a good one.
      secret: NEGATIVE_CAPTCHA_SECRET,
      spinner: request.remote_ip, 
      # Whatever fields are in your form
      fields: [:name, :email, :message],  
      params: params
    )
  end  

  def connect_to_eventbrite

    eb_auth_tokens = { app_key: ENV['EVENTBRITE_APP_KEY'],
                   user_key: ENV['EVENTBRITE_USER_KEY']}
    eb_client = EventbriteClient.new(eb_auth_tokens)
  end
end
