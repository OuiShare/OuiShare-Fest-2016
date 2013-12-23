class Event < ActiveRecord::Base
  attr_accessible :edition_year, :end_date, :location, :start_date

  has_many :event_indiv_assoc, :class_name => "EventIndividualAssociation", :foreign_key => :event_id
  has_many :individuals, :class_name => "Individual", :through => :event_indiv_assoc

end
