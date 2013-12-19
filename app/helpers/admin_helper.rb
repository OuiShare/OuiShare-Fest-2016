module AdminHelper

  def define_setting_action(setting)
    case setting.title
      when 'SITE_VISIBLE'
        if setting.value == 'false'
          haml_concat raw("<br>")
          button_to "Put the site online", toggle_setting_admin_path(setting), :class => "btn btn-danger btn-sm"
        else
          
          haml_concat raw("<br>")
          button_to "Put the site offline", toggle_setting_admin_path(setting), :class => "btn btn-danger btn-sm"

        end
      when 'ADMIN_STRONG_AUTH'
        if setting.value == 'false'
          haml_concat raw("<br>")
          button_to "Enable Admin strong Auth", toggle_setting_admin_path(setting), :class => "btn btn-danger btn-sm"
        else
          haml_concat raw("<br>")
          button_to "Disable Admin strong Auth", toggle_setting_admin_path(setting), :class => "btn btn-danger btn-sm"
        end
    end
    
  end

end
