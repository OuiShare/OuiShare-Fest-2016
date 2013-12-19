module SetlanguageHelper

  def getcurrentlanguage
    if current_user
      return set_language_set_new_language_path(:language_code => current_user.current_language.to_s.to_sym)
    else
      return set_language_set_new_language_path(:language_code => session[:locale].to_s.to_sym)
    end    
  end
end
