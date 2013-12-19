# encoding: UTF-8

module HomeHelper

  def select_languages
    languages_array = [{"fr" => "Français"},
                       {"en" => "English"}, 
                       {"af" => "Africaan"},
                       {"ja" => "Japanese"}
                      ]
    # select_tag :language, options_for_select([["Francais",set_new_language_path(:language_code => "fr")],['English',set_new_language_path(:language_code => "en")]], getcurrentlanguage)
    select_tag :language, options_for_select(languages_array.map { |h| [h.values.first, set_language_set_new_language_path(:language_code => h.keys.first)]}, getcurrentlanguage), :class => "form-control header-vertical-align language-header-not-connected"
  end
end
