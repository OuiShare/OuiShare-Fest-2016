require 'spec_helper'

describe IndividualTypesController do
  # deactivate_admin_strong_auth

  before(:each) do
    http_login
    @individual_type = FactoryGirl.create(:individual_type)

  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "post 'create'" do
    it "create a new Individual Type" do
      indiv_type_params = FactoryGirl.attributes_for(:individual_type)
      expect { post :create, :article => indiv_type_params }.to change(IndividualType, :count).by(1)    
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit', :id => @individual_type.id
      
      response.should be_success
    end
  end

  describe "put 'update'" do
    it "allows an Individual Type to be updated" do
      prev_updated_at = @individual_type.updated_at
      @indiv_type = {:title => "new_test"}
      put 'update', :id => @individual_type.id, :individual_type => @indiv_type
      assigns[:individual_type].should_not be_new_record
      @individual_type.reload
      @individual_type.updated_at.should > prev_updated_at 
      response.should redirect_to "/individual_types"
    end
  end

end
