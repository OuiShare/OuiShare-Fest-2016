class ApplicationController < ActionController::Base
  protect_from_forgery

  # before_filter :authenticate!
  before_filter :first_visit

  before_filter :set_locale

  before_filter :is_site_open

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def first_visit

    if session[:visited] || Date.current() > Date.parse("2014-03-02")
      @visited = true
    else
      session[:visited] = true
    end

  end
  
  def authenticate!
    login = authenticate_or_request_with_http_basic do |login, password|
      login == "ouishare-fest" && password == "community2014"
    end
    session[:login] = login
  end

  def after_sign_in_path_for(user)    
    request.env["omniauth.origin"] || admin_index_path
  end

  def after_sign_out_path_for(resource_or_scope)    
    root_path
  end

  def sign_in(*args)
    super(*args)
    I18n.locale = current_user.current_language
    session[:locale] = I18n.locale    
  end

  def authenticate_admin!
    if authenticate_user!
      if !current_user.is_admin
        redirect_to root_path, :alert => 'You don\'t have the rights to come here.'
      end
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |u| 
      u.permit(:password, :password_confirmation, :current_password) 
    end
  end

  private  

  def strong_auth

    if (action_name != "strong_auth_access_page" && action_name != "validate_strong_auth")
      
      if Rails.env != "test"
        if Setting.find_by_title("ADMIN_STRONG_AUTH").value == "true"         
          if session[:allowed_admin].blank? && !session[:allowed_admin]          
            redirect_to strong_auth_access_page_admin_index_path, :alert => "Strong Auth Needed"
          end 
        end   
      else
        if Setting.find_by_title("ADMIN_STRONG_AUTH").value == "t"         
          if session[:allowed_admin].blank? && !session[:allowed_admin]          
            redirect_to strong_auth_access_page_admin_index_path, :alert => "Strong Auth Needed"
          end 
        end   
      end
    end 
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  def set_locale

    I18n.locale = session[:locale] || cookies.signed[:locale] ||I18n.default_locale
    session[:locale] = I18n.locale    
    # force local to en for now
    I18n.locale = ":en"
  end  

  def is_site_open
    if !(controller_name == 'home' && action_name == 'site_off') || (controller_name == "sessions" && action_name == "new")
      if Setting.find_by_title('SITE_VISIBLE').value == 'false' 
        if !current_user
          redirect_to home_site_off_path
        end
        if current_user && !current_user.is_admin
          sign_out current_user
          redirect_to home_site_off_path
        end
      end
    end
  end
end
