class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :slug
  attr_accessible :avatar, :birthday_date, :gender, :description
  before_create :generate_slug

  has_many :authentications, :dependent => :delete_all

  Paperclip.interpolates :avatar do |attachment, style|
    attachment.instance.avatar_file_name # or whatever you've named your User's login/username/etc. attribute
  end

  has_attached_file :avatar, :default_url => "/assets/avatar-:style.png", styles: {mini: '32x32#',small: '100x100>',medium: '300x300>'},
  :path => ":rails_root/public/system/users_avatar/:id/:style_:avatar",
  :url => "/system/users_avatar/:id/:style_:avatar"

  # Commenter pour Amazon s3
  # before_post_process :check_file_size
  # def check_file_size
  #   valid?
  #   errors[:avatar_file_size].blank?
  # end
  require 'csv'

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["Nom", "Prenom", "Email", "Date Inscription"]
      all.each do |user|
        csv << [user.last_name, user.first_name, user.email, user.created_at]   
      end
    end    
  end

  def avatar_url
    {
      :mini => avatar.url(:mini),
      :thumb => avatar.url(:thumb)
    }
  end
  
  def to_param
    self.slug
  end

  def name
    self.first_name + ' ' + self.last_name
  end

  def fullname
    self.name
  end

  def set_language(language)
    self.current_language = language
    self.save
  end
  
  # Methode permettant de générer un slug unique avec le nom et prenom de l'utilisateur
  #
  # Cela a pour but de pouvoir identifier de façon certaine chaque utilisateur sans passer par l'id
  def generate_slug
    # self.slug = self.fullname.parameterize
    # TODO : what if slug already taken ?
    if self.first_name != '' && self.last_name != '' && !self.slug && !self.authentication_token
      if User.where(:slug => self.fullname.parameterize).count > 0
        n = 1
        while User.where(:slug => "#{self.fullname.parameterize}-#{n}").count > 0
          n += 1
        end
        self.slug = "#{self.fullname.parameterize}-#{n}"
      else
        self.slug = self.fullname.parameterize
      end
    end
  end

  # Methode permettant récupérer les infos Facebook
  #
  # On utilise cette méthode avec le gem omniauth pour nourir le profil User avec ses infos
  # lorsqu'il se connecte avec facebook
  def feed_details_auth(auth)
    logger.debug(auth)
    case auth[:provider]
    when 'facebook'
      email = auth['extra']['raw_info']['email']
      first_name = auth['extra']['raw_info']['first_name']
      last_name = auth['extra']['raw_info']['last_name']
      gender = auth['extra']['raw_info']['gender']
      image_url = auth['info']['image']
      if !auth['info']['urls']['Facebook'].nil?
        self.facebook_url = auth['info']['urls']['Facebook'].gsub(/(http|https):\/\/www.facebook.com\//, '')
      end
    when 'linkedin'
      email = auth['info']['email']
      first_name = auth['info']['first_name']
      last_name = auth['info']['last_name']
      image_url = auth['info']['image']
      public_profile_url = 
      if !auth['info']['urls']['public_profile'].nil?
        self.linkedin_url = auth['info']['urls']['public_profile'].gsub(/(http|https):\/\/www.linkedin.com\/in\//, '')
      end
    else
      return false
    end
    if self.email.blank?
      self.email = email
    end
    if self.first_name.blank?
      self.first_name = first_name
    end
    if self.last_name.blank?
      self.last_name = last_name
    end
    if self.gender.blank?
      if gender == 'male' 
        gender = 'M'
      elsif gender == 'female'
        gender = 'F'
      end
     
      self.gender = gender
    end
    if !self.avatar.exists?
      self.avatar= URI.parse(image_url)
    end

  end

  # Methode permettant de préparer la BDD pour creer une Authentication
  #  

  def apply_omniauth(auth)
    return authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
  end

end
