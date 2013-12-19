module ControllerMacros

  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in FactoryGirl.create(:admin) # Using factory girl as an example
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      sign_in user
    end
  end

  def deactivate_admin_strong_auth
    setting = Setting.find_by_title("ADMIN_STRONG_AUTH")
    setting.value = false
    setting.save
  end

  def activate_admin_strong_auth
    setting = Setting.find_by_title("ADMIN_STRONG_AUTH")
    setting.value = true
    setting.save
  end
end