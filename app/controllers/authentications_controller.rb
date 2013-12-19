##
# AuthenticationController Class, contain all the action an Authentication can do.
#
# == Summary
# 
# 
# 
# == Example
# 
#   
#

class AuthenticationsController < ApplicationController

  # Method to create an authentication.
  # 
  # First of all we check if we are currently signed in.
  # 
  # If yes, We check for an Authentication record in the DB
  #   If there is one we redirect the user to root
  #   If not, we gather all the facebook data we need on the user then proceed to save it
  # If no, We check for an Authentication record in the DB
  #   If there is one, we sign him in and redirect him to the correct url
  #   If not, We check the User DB to search for an existing user with the facebook email
  #     If yes, we redirect user to root
  #     If not, We create a new User in the DB and feed it with his facebook infos
  # Then we proceed to save the new User in DB and redirect him to root
  #
  def create
    auth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])

    if user_signed_in? # Association and not Login
      if authentication
        redirect_to me_edit_profile_path, :notice => 'You already associated your account with '+auth['provider']
      else
        current_user.apply_omniauth(auth)
        current_user.feed_details_auth(auth)
        if current_user.save
          redirect_to root_path, :notice => 'Account successfully linked with '+auth['provider']
        else
          redirect_to root_path, :notice => 'Nothing happened, please try again'
        end
      end
    else # Log In
      if authentication # Copasser already came here. Sign in Ok
        sign_in(:user, authentication.user)
        redirect_url = (params[:state].blank?) ? me_edit_profile_path : params[:state]
        redirect_to(redirect_url, :notice => 'Signed in successfully.')

      else # Check if email already used
        @user = User.unscoped.find_by_email(get_email_auth(auth))

        if @user # copasser exists but withtout authentication
          redirect_to(root_path, :notice => 'This email address already exists. Please login first and then associate your '+auth['provider']+' account')
        else # Account creation
          @user = User.new
          @user.apply_omniauth(auth)
          @user.feed_details_auth(auth)
          
          if @user.save(:validate => false)
            # CopasserMailer::welcome(@copasser)
            sign_in(:user, @user)
            
            redirect_to root_path(:connect => auth['provider']), notice: auth['provider']+' connect successfull, please complete your profile ...'
          else
            redirect_to root_url, alert: 'An error occurred while creating the account, please try again.'
          end
        end
      end
    end
    
  end

  def undo_account_link

    @authentication = current_user.authentications.where(:provider => params[:provider]).first
    @authentication.destroy
    
    if @authentication.save
      redirect_to me_edit_profile_path, :notice => 'Account succesfully delinked with'+params[:provider]
    else
      redirect_to me_edit_profile_path, :notice => 'An error occured, please try again'
    end
  end

  def failure
    if current_user
      redirect_to me_edit_profile_path
    else
      redirect_to root_path
    end
  end

  

  private

  def get_email_auth(auth)
    case auth['provider']
    when 'facebook'
      email = auth['extra']['raw_info']['email']
    when 'linkedin'
      email = auth['extra']['raw_info']['emailAddress']
    else
      email = ''
    end
    return email
  end

end
