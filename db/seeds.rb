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


# This script below was used to move all speakers to a new 'People' Category for the OSfest '15 launch. It's not needed now.

# speakers_individual_type = IndividualType.find_by_title('Speakers')
# people_individual_type = IndividualType.find_by_title('People')
# logger.debug(speakers_individual_type.title + ' Individual Type id is : ' + speakers_individual_type.id.to_s)
# logger.debug(people_individual_type.title + ' Individual Type id is : ' + people_individual_type.id.to_s)
# created_elems = 0

# Individual.all.each do |individual|
#   if IndividualTypeAssociation.find_by_individual_id_and_individual_type_id(individual.id, speakers_individual_type.id) 
#     IndividualTypeAssociation.find_by_individual_id_and_individual_type_id(individual.id, speakers_individual_type.id) do |individual_type_association|
#     if !IndividualTypeAssociation.find_by_individual_id_and_individual_type_id(individual.id, people_individual_type.id)
#       IndividualTypeAssociation.create(:individual_id => individual.id, :individual_type_id => people_individual_type.id)
#       created_elems += 1 
#     end
#     individual_type_association.destroy
#     end
#   end
# end 
# logger.debug(created_elems.to_s + ' Speakers moved to People Individual type')