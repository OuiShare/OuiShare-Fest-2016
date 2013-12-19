class SetLanguageController < ApplicationController

  def set_new_language
    I18n.locale = params[:language_code].to_sym
    set_session_and_redirect
  end 

  private
  def set_session_and_redirect
    session[:locale] = I18n.locale
    if current_user
      current_user.set_language(I18n.locale)
      cookies.permanent.signed[:locale] = I18n.locale   
    else
      cookies.permanent.signed[:locale] = I18n.locale     
    end
    redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to :root
  end
end
