class EventIndividualAssociation < ActiveRecord::Base
  attr_accessible :individual_id, :event_id, :individual_type_id

  belongs_to :individual
  belongs_to :event

end
