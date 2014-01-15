class AdminController < ApplicationController
  before_filter :authenticate_admin!, :strong_auth
  
  def index
    @settings = Setting.order("title ASC")
  end


  def export_users
    @users = User.all 
    
    respond_to do |format|
      format.html
      format.csv {send_data User.to_csv}
      format.xls 
    end
  end

  def export_newsletter_subscribers

    @newsletter_subscribers = NewsletterSubscriber.all
    respond_to do |format|
      format.html
      format.csv {send_data NewsletterSubscriber.to_csv}
      format.xls 
    end
  end

  def toggle_admin
    @user = User.find_by_slug(params[:id])
    previous_state = @user.is_admin
    @user.is_admin = !previous_state

    if @user.save
      redirect_to :back, :notice => 'The user has been updated'
    else
      redirect_to :back, :alert => 'An error occured'
    end
  end

  def toggle_setting
    @setting = Setting.find_by_title(params[:id])
    case @setting.value
      when 'true'
        @setting.value = 'false'
      when 'false'
        @setting.value = 'true' 
      else
        @setting.value = 'true'
    end

    if @setting.save
      redirect_to :back, :notice => 'The setting has been updated'
    else
      redirect_to :back, :alert => 'An error occured'
    end
  end

  def settings_list
    @settings = Setting.order("title ASC")
  end

  def users_list
    @users = User.order("first_name ASC")
  end

  def individuals_list
    @individuals = Individual.all
  end

  def individual_type
    @individual_type = IndividualType.find_by_title(params[:id])
    @members = @individual_type.get_members
  end

  def individual_types_list
    @individual_types = IndividualType.order("title ASC")
  end

  def strong_auth_access_page
    @admin = current_user
    admin_code = AdminOneShotCode.find_or_create(@admin)
    admin_code.generate_code
    admin_code.send_email    
  end

  def validate_strong_auth
    entered_code = params[:admin_code]
    admin_code = AdminOneShotCode.find_by_admin_id(current_user.id)
    
    if admin_code.compare_code(params[:admin_code])
      session[:allowed_admin] = true         
    end

    redirect_to admin_index_path
  end

  def restart_nginx_server
    executed_bash = "restart"
    bash_cmd = ENV['PATH_BIN'] + executed_bash

    current_directory_contents = system(bash_cmd) 
    
    render :nothing => true
  end
end
