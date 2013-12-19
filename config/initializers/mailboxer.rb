Mailboxer.setup do |config|

  #Configures if you applications uses or no the email sending for Notifications and Messages
  config.uses_emails = false

  #Configures the default from for the email sent for Messages and Notifications of Mailboxer
  #TODO: check the validity of no-reply mail
  config.default_from = "Pitch Me <contact@pitch-me.fr>"

  config.notification_mailer = nil
  # config.message_mailer = CustomMessageMailer

  #Configures the methods needed by mailboxer
  config.email_method = :get_email
  config.name_method = :name

  #Configures if you use or not a search engine and wich one are you using
  #Supported enignes: [:solr,:sphinx]
  # config.search_enabled = false
  # config.search_engine = :solr
end
