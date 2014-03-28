# encoding: UTF-8

module HomeHelper

  def select_languages
    languages_array = [{"en" => "EN"}, 
                       {"fr" => "FR"},
                       {"es" => "ES"},
                       {"de" => "DE"},
                       {"it" => "IT"},
                       {"nl" => "NL"},
                      ]
    # select_tag :language, options_for_select([["Francais",set_new_language_path(:language_code => "fr")],['English',set_new_language_path(:language_code => "en")]], getcurrentlanguage)
    select_tag :language, options_for_select(languages_array.map { |h| [h.values.first, set_language_set_new_language_path(:language_code => h.keys.first)]}, getcurrentlanguage), :class => "header-vertical-align language-header"
  end

  def display_gravatar(email_address)
    hash = Digest::MD5.hexdigest(email_address)
    image_src = "http://www.gravatar.com/avatar/#{hash}?d=mm"
    # return image_tag image_src, :class => "img-circle gravatar-display"    
    image_src
  end
end
