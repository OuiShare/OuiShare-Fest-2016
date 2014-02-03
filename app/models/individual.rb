class Individual < ActiveRecord::Base
  attr_accessible :birthday, :company_name, :description, :first_name, :function, :last_name, :individual_type_id, :twitter_account, :url, :email
  attr_accessible :attachment, :slug, :display_order
  Paperclip.interpolates :attachment do |attachment, style|
  attachment.instance.attachment_file_name # or whatever you've named your User's login/username/etc. attribute
  end

  Paperclip.interpolates :class_name_individual do |attachment, style|
  attachment.instance.class.name # or whatever you've named your User's login/username/etc. attribute
  end

  has_attached_file :attachment, :default_url => "/assets/individual_default_avatar-:style.png", 
  :styles => {mini: '30x30#',small: '100x100>',medium: '300x300>',custom: '220x220#', partner_size: 'x138'},
  :path => ":rails_root/public/system/:class_name_individual/:id/attachment/:style_:attachment",
  :url => "/system/:class_name_individual/:id/attachment/:style_:attachment"

  # belongs_to :individual_type, :class_name => "IndividualType", :foreign_key => :individual_type_id

  has_many :individual_types_assocs, :class_name => "IndividualTypeAssociation", :foreign_key => :individual_id, :dependent => :delete_all
  has_many :individual_types, :class_name => "IndividualType", :through => :individual_types_assocs
  
  has_many :event_indiv_assoc, :class_name => "EventIndividualAssociation", :foreign_key => :individual_id
  has_many :events, :class_name => "Event", :through => :event_indiv_assoc

  before_create :generate_slug
  after_save :export_to_yaml
  after_destroy :delete_from_yaml


  def export_to_yaml
    if description_changed?
      d = YAML::load_file(ENV['YAML_INDIVIDUALS_FILE_PATH']) #Load
      
      if d['en']['individuals_biography'].blank?
        d['en']['individuals_biography'] = {}
      end            
      d['en']['individuals_biography'][self.slug] = self.description
      
      
      File.open(ENV['YAML_INDIVIDUALS_FILE_PATH'], 'w') do |f|
        f.write d.to_yaml
      end
      connect_and_push_to_transifex()
    end
  end

  def delete_from_yaml
    d = YAML::load_file(ENV['YAML_INDIVIDUALS_FILE_PATH'])
    if !d['en']['individuals_biography'][self.slug].blank?
        d['en']['individuals_biography'].delete self.slug
    end   
    
    File.open(ENV['YAML_INDIVIDUALS_FILE_PATH'], 'w') do |f|
      f.write d.to_yaml
    end
    connect_and_push_to_transifex()
  end
  
  def generate_slug    
    if self.first_name != '' && self.last_name != '' && !self.slug 
      if Individual.where(:slug => self.fullname.parameterize).count > 0
        n = 1
        while Individual.where(:slug => "#{self.fullname.parameterize}-#{n}").count > 0
          n += 1
        end
        self.slug = "#{self.fullname.parameterize}-#{n}"

      else
        self.slug = self.fullname.parameterize
        
      end
    end  
  end

  def add_to_current_event
    
    event = Event.find_by_edition_year(ENV["OUISHARE_FEST_EVENT_YEAR"])
   
    if !EventIndividualAssociation.find_by_event_id_and_individual_id(event.id, self.id)
      
      self.individual_types.each do |indiv_type|
        assoc = {
          :event_id => event.id,
          :individual_type_id => indiv_type.id,
          :individual_id => self.id
        }
        EventIndividualAssociation.create(assoc)

      end 
    end   
    
  end

  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #  
  # function: full_name
  # Return the full name of an individual
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
  def fullname
    @fullname = ""
    if !self.first_name.blank?
      @fullname = self.first_name
    end

    if !self.last_name.blank?
      @fullname += ' ' + self.last_name
    end

    @fullname
  end

  def self.get_partners_by_function
    @partners_array = []
    @partners = Individual.joins(:individual_types).merge(IndividualType.where(:title => "Partners"))
    @functions = @partners.select("DISTINCT(function)").order("function ASC")
    @functions.each do |function|
      @partners = Individual.where(:function => function.function)
      @partners_array.push({function.function => @partners})
      
    end    
    @partners_array
  end


  private 

  def connect_and_push_to_transifex
    base_url = ENV['TRANSIFEX_BASE_URL']
       
    request_response = nil    
    d = YAML::load_file(ENV['YAML_INDIVIDUALS_FILE_PATH'])
    file = {}
    file['content'] = d.to_yaml
    file = file.to_json

    request_url = ENV['TRANSIFEX_INDIVIDUALS_URL']
    uri = URI(base_url + request_url)

    res = Net::HTTP.start(uri.host, 80) do |http|
      request = Net::HTTP::Put.new uri.request_uri
      request.basic_auth ENV['TRANSIFEX_CREDENTIAL_LOGIN'], ENV['TRANSIFEX_CREDENTIAL_SECRET']
      request.content_type = "application/json"
      request.body = file
      
      response = http.request request
     
      request_response = response.body
      
    end
    return request_response
  end

end
