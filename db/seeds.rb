# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

logger = Logger.new(STDOUT)

individual_types = ["TYPE_01", "TYPE_02"]
settings = [{ :title => "SITE_VISIBLE", :value => "true"}, 
            { :title => "ADMIN_STRONG_AUTH", :value => "false"}
           ]

created_elems = 0
individual_types.each do |individual_type|
  if !(IndividualType.find_by_title(individual_type))
    IndividualType.create(:title => individual_type)
    created_elems += 1
  end
end
logger.debug(created_elems.to_s + ' Individual Types seeded')


created_elems = 0
settings.each do |setting|
  if !(Setting.find_by_title(setting[:title]))
    Setting.create(:title => setting[:title], :value => setting[:value])
    created_elems += 1
  end
end
logger.debug(created_elems.to_s + ' Settings seeded')