class MeController < ApplicationController
  before_filter :authenticate_user!

  # Get the current user then
  # Direct to the edit.html.haml
  # where he will manage his profile
  require 'yaml'
  def dashboard
    @user = current_user  
    
  end
  
  def edit_profile
    @user = current_user
    render 'edit'    
  end  

  # Method executed when submitting the edit form
  # Persist in the DB the changes the user made on the edit page
  #
  def update_profile

    if !(params[:redirect_anchor].blank?)
      anchor = params[:redirect_anchor]
    else
      anchor = ''
    end

    @user = current_user

    respond_to do |format|
      
      if @user.update_attributes(params[:user])
        format.html { redirect_to me_edit_profile_path, notice: 'Your profile was successfully updated.' }
      else
        format.html { redirect_to me_edit_profile_path, alert: 'Error occured' }
      end        
    end
  end

  # Get the current user then
  # redirect to his preferences page
  # where he can manage his allergies, favorite foods, alimentaries preferences 
  def preferences
    @user = current_user
  end

  def change_password
    @user = current_user
    
  end

  def apply_change_password
    @user = current_user
    
    if @user.update_with_password(user_params)
      sign_in @user, :bypass => true
      redirect_to root_path, :notice => "Password succesfully updated"
    else
      redirect_to me_change_password_path, :alert => "An error occured"
    end
  end


  private

  def user_params
    params.required(:user).permit(:password, :password_confirmation, :current_password)
  end
end