class AdminOneShotCode < ActiveRecord::Base
  attr_accessible :admin_id, :code

  def generate_code
    number = ('0'..'9').to_a
    code = (0...6).map{ number[rand(number.length)] }.join
    self.code = code
    self.save   
  end

  def send_email
    admin = User.find(self.admin_id)
    AdminMailer.send_admin_code(admin, self.code)
    
  end

  def compare_code(code)
    if code == self.code
      return true
    else
      return false
    end    
  end

  def self.find_or_create(admin)

    if ! admin_code = AdminOneShotCode.find_by_admin_id(admin.id)
      AdminOneShotCode.create(:admin_id => admin.id)
    else
      return admin_code
    end
  end
end
