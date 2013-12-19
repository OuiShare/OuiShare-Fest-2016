class IndividualTypeAssociation < ActiveRecord::Base
  attr_accessible :individual_id, :individual_type_id

  belongs_to :individual 
  belongs_to :individual_type
end
