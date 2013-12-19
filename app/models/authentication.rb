##
# Authentication Class, represent the connection of a User with a social network
#
# == Summary
# 
# This model allows us to know when a User use a Social Network such as Facebook to connect to our site.
# 
# == Example
# 
#   
#
class Authentication < ActiveRecord::Base
  attr_accessible :user_id, :provider, :token, :uid

  belongs_to :user
end
