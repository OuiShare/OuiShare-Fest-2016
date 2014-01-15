class NewsletterSubscriber < ActiveRecord::Base
  attr_accessible :email

  require 'csv'

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["id","Email"]
      all.each do |newsletter_subscriber|
        csv << [newsletter_subscriber.id,newsletter_subscriber.email]   
      end
    end    
  end

end
