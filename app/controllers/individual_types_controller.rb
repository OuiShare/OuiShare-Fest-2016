class IndividualTypesController < ApplicationController
  before_filter :authenticate_admin!, :strong_auth, :except => [:index, :show]
  def index
    @individual_types = IndividualType.order("title ASC")
    
  end

  def show
    @individual_type = IndividualType.find_by_title(params[:id])
    @members = @individual_type.get_members
  end

  def new
    @individual_type = IndividualType.new   
  end

  def create

    @individual_type = IndividualType.new(params[:individual_type])
    if @individual_type.save

      redirect_to individual_types_list_admin_index_path, :notice => "Created"
    else
      redirect_to individual_types_list_admin_index_path, :alert => "An error occured"
    end
  end

  def edit
    @individual_type = IndividualType.find_by_title(params[:id])
  end

  def update
    @individual_type = IndividualType.find_by_title(params[:id])

    if @individual_type.update_attributes(params[:individual_type])
      redirect_to individual_types_list_admin_index_path, :notice => "Updated"
    else
      redirect_to :back, :alert => "An error occured"
    end
  end

  def destroy
    @individual_type = IndividualType.find_by_title(params[:id])

    if @individual_type.destroy
      redirect_to individual_types_list_admin_index_path, :notice => "Deleted"
    else
      redirect_to :back, :alert => "An error occured"
    end    
  end
end
