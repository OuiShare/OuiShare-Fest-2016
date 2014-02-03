class IndividualsController < ApplicationController
  before_filter :authenticate_admin! , :except => [:index, :show]
  # TODO : 
  # Ajout / Suppression attachment, birthday, tous les autres champs ...
  # before_filter Admin
  # function pour récupérer la liste des Individuals d'un certain type
  # Préciser le groupe de la personne avec une liste déroulante

  def index
    @individuals = Individual.all
  end

  def show
    @individual = Individual.find(params[:id])
  end

  def new
    @individual = Individual.new
    @is_checked = params[:is_checked]
  end

  def create
    # @individual = Individual.new(params[:individual])

    if @individual = Individual.create(params[:individual])         
      updateIndividualTypes(params[:individual_types])     
      @individual.add_to_current_event   
      redirect_to individuals_list_admin_index_path, :notice => 'Creation successfull'
    else
      redirect_to individuals_list_admin_index_path, :alert => 'An error occured'
    end

  end

  def edit
    @individual = Individual.find(params[:id])
  end

  def update

    @individual = Individual.find(params[:id])
    if @individual.update_attributes(params[:individual])      
      updateIndividualTypes(params[:individual_types])      
      redirect_to individuals_list_admin_index_path, :notice => 'Update successfull'
    else
      redirect_to individuals_list_admin_index_path, :alert => 'An error occured'
    end

  end

  def destroy
    @individual = Individual.find(params[:id])
    if @individual.destroy 
      redirect_to individuals_list_admin_index_path, :notice => 'Deleted successfully'
    else
      redirect_to individuals_list_admin_index_path, :alert => 'An error occured'
    end
  end
  private

  def updateIndividualTypes(params=[])
     
    params.each do |type|
      if !IndividualTypeAssociation.find_by_individual_id_and_individual_type_id(@individual.id, type)
        IndividualTypeAssociation.create(:individual_id => @individual.id, :individual_type_id => type)
      end
    end  

    IndividualType.all.each do |type|      
      if(IndividualTypeAssociation.find_by_individual_id_and_individual_type_id(@individual.id, type.id)&& !(params.include?(type.id.to_s)))
        indiv_type =IndividualTypeAssociation.find_by_individual_id_and_individual_type_id(@individual.id, type.id)
        indiv_type.destroy
      end
    end
  end
end
