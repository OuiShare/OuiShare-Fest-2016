class Translation < ActiveRecord::Base
  attr_accessible :interpolations, :is_proc, :key, :locale, :value
end
