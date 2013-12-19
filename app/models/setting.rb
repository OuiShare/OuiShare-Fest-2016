class Setting < ActiveRecord::Base
  attr_accessible :title, :value

  def to_param
    self.title
  end
end
