class AdminMailer < ActionMailer::Base
  default template_path: 'mailers/admin_mailer'
  default from: "Pitch Me <contact@pitch-me.fr>"

  def contact_staff_email(message, name, email)

    @message = message unless !message
    @name = name unless !name
    @email = email unless !email       
    mail(to: "frederic.grais@gmail.com", subject: '[Pitch Me] ' + 'New contact from ' + @name).deliver
    
  end

  def send_admin_code(admin, code)
    @code = code
    @admin = admin
    
    mail(to: admin.email ,subject: '[Admin] ' + 'Your code is ' + @code).deliver

  end

end
