class Individual < ActiveRecord::Base
  attr_accessible :birthday, :company_name, :description, :first_name, :function, :last_name, :individual_type_id, :twitter_account, :url, :email
  attr_accessible :attachment, :slug
  Paperclip.interpolates :attachment do |attachment, style|
  attachment.instance.attachment_file_name # or whatever you've named your User's login/username/etc. attribute
  end

  Paperclip.interpolates :class_name_individual do |attachment, style|
  attachment.instance.class.name # or whatever you've named your User's login/username/etc. attribute
  end

  has_attached_file :attachment, :default_url => "/assets/individual_default_avatar-:style.png", 
  :styles => {mini: '30x30#',small: '100x100>',medium: '300x300>'},
  :path => ":rails_root/public/system/:class_name_individual/:id/attachment/:style_:attachment",
  :url => "/system/:class_name_individual/:id/attachment/:style_:attachment"

  belongs_to :individual_type, :class_name => "IndividualType", :foreign_key => :individual_type_id

  has_many :individual_types_assocs, :class_name => "IndividualTypeAssociation", :foreign_key => :individual_id, :dependent => :delete_all
  has_many :individual_types, :class_name => "IndividualType", :through => :individual_types_assocs
 
  before_create :generate_slug

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

  def to_param
    self.slug    
  end
end
