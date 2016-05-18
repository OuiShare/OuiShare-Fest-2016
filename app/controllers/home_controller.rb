class HomeController < ApplicationController

  # For negative captcha
  before_filter :contact_captcha, :only => [:contact, :contact_email]
  
  require 'eventbrite-client'
  require 'net/http'
  
  def index    

    # Magazine.fetch_last_posts
    # @magazines = Magazine.order("published_at desc").limit(3)

    if IndividualType.find_by_title('Team')
      @team_members = IndividualType.find_by_title('Team').get_members
      if ENV["DISPLAYED_TEAM_MEMBERS"].to_i > @team_members.count
        displayed_team_members_number = @team_members.count
      else
        displayed_team_members_number = ENV["DISPLAYED_TEAM_MEMBERS"].to_i
      end
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
      @displayed_team_members = @team_members.first(displayed_team_members_number)
      @hidden_team_members = @team_members.last(@team_members.count - displayed_team_members_number)
    end

    if IndividualType.find_by_title('Featured')
      @featured = IndividualType.find_by_title('Featured').get_members
      
      if ENV["DISPLAYED_FEATURED"].to_i > @featured.count
        displayed_featured_number = @featured.count
      else
        displayed_featured_number = ENV["DISPLAYED_FEATURED"].to_i
      end
    end

    if IndividualType.find_by_title('Partners')      
      @partners = IndividualType.find_by_title('Partners').get_members
    end
    if IndividualType.find_by_title('Friends')      
      @friends = IndividualType.find_by_title('Friends').get_members
    end
    if IndividualType.find_by_title('Media Partners')      
      @media_partners = IndividualType.find_by_title('Media Partners').get_members
    end
    if IndividualType.find_by_title('Supporters')      
      @supporters = IndividualType.find_by_title('Supporters').get_members
    end
    if IndividualType.find_by_title('Patronage')      
      @patronage = IndividualType.find_by_title('Patronage').get_members
    end

    eventbrite_instance = connect_to_eventbrite()
    begin
      @ouishare_fest_attendees = eventbrite_instance.event_list_attendees({ "id" => ENV["EVENTBRITE_EVENT_ID"] })
    rescue
      @ouishare_fest_attendees = nil
    end

  end

  def about

    @lng = '39.8331'
    @lat = '-94.822794'

    
    @description = render_to_string(:partial => "/home/partials/contact_infowindow").squish.gsub('"','\'')

    @picture = "assets/markers/marker_002.png"
    @title = "Title"
    @width = "32"
    @height = "32"

    @marker = '[{"description":"' + @description + '","picture":"' + @picture + '","width":' + @width + ',"height":' + @height + ',"title":"' + @title + '","lng":' + @lng + ', "lat": ' + @lat + '}]'

  end

    def participants
      eb_auth_tokens = { app_key: ENV['EVENTBRITE_APP_KEY'],
                   access_token: ENV['EVENTBRITE_USER_KEY']}
      eb_client = EventbriteClient.new(eb_auth_tokens)
      eventbrite_instance = connect_to_eventbrite()

    begin
      @ouishare_fest_attendees = eventbrite_instance.event_list_attendees({ "id" => ENV["EVENTBRITE_EVENT_ID"] })
      #@ouishare_fest_attendees = eb_client.event_list_attendees({ "id" => ENV["EVENTBRITE_EVENT_ID"] })
    rescue
      @ouishare_fest_attendees = nil
    end
    if IndividualType.unscoped.find_by_title('Team')
      @team_members = IndividualType.unscoped.find_by_title('Team').get_members
      if ENV["DISPLAYED_TEAM_MEMBERS"].to_i > @team_members.count
        displayed_team_members_number = @team_members.count
      else
        displayed_team_members_number = ENV["DISPLAYED_TEAM_MEMBERS"].to_i
      end
    end

    if IndividualType.find_by_title('Curators')
      @curators = IndividualType.find_by_title('Curators').get_members
      if ENV["DISPLAYED_CURATORS"].to_i > @curators.count
        displayed_curators_number = @curators.count
      else
        displayed_curators_number = ENV["DISPLAYED_CURATORS"].to_i
      end
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
      @displayed_team_members = @team_members.first(displayed_team_members_number)
      @hidden_team_members = @team_members.last(@team_members.count - displayed_team_members_number)
    end

    if IndividualType.find_by_title('Featured')
      @featured = IndividualType.find_by_title('Featured').get_members
      
      if ENV["DISPLAYED_FEATURED"].to_i > @featured.count
        displayed_featured_number = @featured.count
      else
        displayed_featured_number = ENV["DISPLAYED_FEATURED"].to_i
      end
    end

    if IndividualType.find_by_title('Partners')      
      @partners = IndividualType.find_by_title('Partners').get_members
    end
    if IndividualType.find_by_title('Friends')      
      @friends = IndividualType.find_by_title('Friends').get_members
    end
    if IndividualType.find_by_title('Media Partners')      
      @media_partners = IndividualType.find_by_title('Media Partners').get_members
    end
    if IndividualType.find_by_title('Supporters')      
      @supporters = IndividualType.find_by_title('Supporters').get_members
    end
    if IndividualType.find_by_title('Patronage')      
      @patronage = IndividualType.find_by_title('Patronage').get_members
    end

    
    end

  def join
  end

  def sliders
    Magazine.fetch_last_posts
    @magazines = Magazine.all

    if IndividualType.find_by_title('Featured')
      @featured = IndividualType.find_by_title('Featured').get_members
      
      if ENV["DISPLAYED_FEATURED"].to_i > @featured.count
        displayed_featured_number = @featured.count
      else
        displayed_featured_number = ENV["DISPLAYED_FEATURED"].to_i
      end
    end

  end

  def news
    Magazine.fetch_last_posts
    @magazines = Magazine.order("published_at desc").all
  end

  def media
    Magazine.fetch_last_posts
    @magazines = Magazine.order("published_at desc").limit(3)
  end

  def faq
  end

  def site_off
  end

  def openday
    if IndividualType.find_by_title('ODSpeakers')
      @odspeaker = IndividualType.find_by_title('ODSpeakers').get_members
    end
    if IndividualType.find_by_title('ODPartners')      
      @odpartners = IndividualType.find_by_title('ODPartners').get_members
    end
    if IndividualType.find_by_title('ODCommunity')      
      @odcommunity = IndividualType.find_by_title('ODCommunity').get_members
    end
  end

  def program
    # @request_response = connect_to_sched().force_encoding('UTF-8')

    if IndividualType.find_by_title('Curators')
      @curators = IndividualType.find_by_title('Curators').get_members
      if ENV["DISPLAYED_CURATORS"].to_i > @curators.count
        displayed_curators_number = @curators.count
      else
        displayed_curators_number = ENV["DISPLAYED_CURATORS"].to_i
      end
    end
  end

  def forward
    if IndividualType.find_by_title('Jury')
      @jury = IndividualType.find_by_title('Jury').get_members
      if ENV["DISPLAYED_JURY"].to_i > @jury.count
        displayed_jury_number = @jury.count
      else
        displayed_jury_number = ENV["DISPLAYED_JURY"].to_i
      end
    end
  end

  def zero_waste_event
    if IndividualType.find_by_title('Zero Waste Partners')
      @zerowaste = IndividualType.find_by_title('Zero Waste Partners').get_members
    end
  end

  def contact
    # Set marker options for contact map
    @lng = '39.8331'
    @lat = '-94.822794'
    
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

  def newsletter_collect_email
    email = params[:email_address]
    if !NewsletterSubscriber.find_by_email(email)
      new_newsletter_email = NewsletterSubscriber.new(:email => email)
      if new_newsletter_email.save 
        redirect_to root_path 
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
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
                   access_token: ENV['EVENTBRITE_USER_KEY']}
    eb_client = EventbriteClient.new(eb_auth_tokens)

  end

  def connect_to_sched
    base_url = "http://testfffffffff2013.sched.org/api"
    api_secret = "9c0e4074626d1d193078b9d0ed443f53"
    username = "frederic.grais@gmail.com"
    password = "258741"    
    request_url = "/auth/login?api_key=#{api_secret}&username=#{username}&password=#{password}"
    request_response = nil
    uri = URI(base_url + request_url)
    
    res = Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Get.new uri.request_uri
      response = http.request request
      # res = MultiJson.load(response.body)
      schedule_uri = "/schedule/get?api_key=#{api_secret}&se=#{response.body}&l=1"
      new_uri = URI(base_url + schedule_uri)
      request = Net::HTTP::Get.new new_uri.request_uri
      response = http.request request
      request_response = response.body
      
    end
    return request_response
  end
end
