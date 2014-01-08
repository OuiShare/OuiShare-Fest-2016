class TraductionsController < ApplicationController
  before_filter :authenticate_admin!, :strong_auth
  def index
    @traductions = Translation.all  
    @traduction_keys = Translation.select("DISTINCT(KEY)").order("key ASC")
    
  end

  def show
  end

  def new
    # @availables_languages = I18n.available_locales.sort    
    @availables_languages = I18n.available_locales.select {|locale| locale.to_s == 'en'}
  end

  def create    
    if params[:key].split('.').length == 2
      save_successfull = true    
      params[:value].each do |value|
        if !value[1].blank?
          if !Translation.find_by_locale_and_key(value[0], params[:key])
            translation = {:locale => value[0],
                           :key => params[:key],
                           :value => value[1]
                          }                      
            new_trans = Translation.new(translation)
            
            if !new_trans.save  
              save_successfull=false
            end
          end
        end
      end    
      if save_successfull
        redirect_to traductions_path, :notice => "Trads Succesfully added"
      else
        redirect_to traductions_path, :notice => "An error occured"
      end
    else
      redirect_to :back, :notice => "Please enter a key following this pattern : main_key.sub_key"
    end
  end

  def edit
    @translation = Translation.find(params[:id])
    # @availables_languages = I18n.available_locales.sort
    @availables_languages = I18n.available_locales.select {|locale| locale.to_s == 'en'}
  end

  def update
    save_successfull = true
    @translations = Translation.where(:key => params[:key])    
    params[:value].each do |value|
      translation = @translations.select {|trans| trans.locale == value[0]}
      if !value[1].blank?        
        if translation.count > 0
          if translation.first.value != value[1]
            if !translation.first.update_attributes(:value => value[1])
              save_successfull = false
            end
          end
        else
          translation = {:locale => value[0],
                         :key => params[:key],
                         :value => value[1]
                        }                      
          new_trans = Translation.new(translation)
          if !new_trans.save
            save_successfull = false
          end
        end
      else               
        if translation.count > 0
          if !translation.first.destroy
            save_successfull = false
          end
        end
      end
    end
    if save_successfull
      redirect_to traductions_path, :notice => "Trads Succesfully updated"
    else
      redirect_to traductions_path, :notice => "An error occured"
    end
  end

  def destroy
    @translation = Translation.find(params[:id])
    @translations = Translation.where(:key => @translation.key)
    save_successfull = true

    @translations.each do |translation|
      if !translation.destroy
        save_successfull = false

      end
    end

    if save_successfull
      redirect_to traductions_path, :notice => "Trads Succesfully destroyed"
    else
      redirect_to traductions_path, :notice => "An error occured"
    end
  end  
end
