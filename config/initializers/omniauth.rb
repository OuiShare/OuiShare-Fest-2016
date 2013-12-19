Rails.application.config.middleware.use OmniAuth::Builder do
  # The following is for facebook

  if Rails.env.development?
    provider :facebook, ENV['FACEBOOK_APP_ID_DEV'], ENV['FACEBOOK_APP_SECRET_DEV'], {:scope => 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access, publish_stream, publish_actions', :image_size => 'large'}
  else  
    provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], {:scope => 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access, publish_stream, publish_actions', :image_size => 'large'}
  end

  OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  }
end