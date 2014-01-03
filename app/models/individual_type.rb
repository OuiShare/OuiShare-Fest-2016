class IndividualType < ActiveRecord::Base
  attr_accessible :title 
  
  has_many :individual_types_assocs, :class_name => "IndividualTypeAssociation", :foreign_key => :individual_type_id, :dependent => :delete_all
  has_many :individuals, :class_name => "Individual", :through => :individual_types_assocs

  def get_member_number
    self.individuals.count    
  end

  def get_members
    self.individuals.order('display_order ASC')    
  end

  def to_param
    self.title    
  end
end