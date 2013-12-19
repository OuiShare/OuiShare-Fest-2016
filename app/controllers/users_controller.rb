  ##
# UsersController Class, contain users related functionnality.
#
# == Summary
#   Allow to show a user profile and the list of all users
# 
# 
# == Example
# 
#   
#
class UsersController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  # Direct to the profile of a user
  #
  #
  def show
    @user = User.find_by_slug(params[:id])
    
    # respond_to do |format|
    #   format.html # show.html.erb
    #   format.json { render json: @user }
    # end
    
  end

  def edit
    @user = User.find_by_slug(params[:id])
  end


  # Direct to the user's list
  #
  #
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user }
    end
  end

  

end
