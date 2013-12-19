require 'spec_helper'

include Devise::TestHelpers

describe TraductionsController do

  login_admin
  # deactivate_admin_strong_auth

  before(:each) do
    http_login
    @traduction = FactoryGirl.create(:translation_en)        
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', :id => @traduction.id
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "post 'create'" do
    context "with new valid attributes" do
      it "should create a new record" do           
        expect { post :create,:key => "test", :value => {"en" => "Hello"} }.to change(Translation, :count).by(1) 
      end
    end
    context "with already used key" do
      it "should not create a new record" do
        expect { post :create,:key => "hello", :value => {"en" => "Hello"} }.to change(Translation, :count).by(0) 
      end
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit', :id => @traduction.id
      response.should be_success
    end
  end

  describe "PUT 'update'" do
    context "updating existing trad" do
      it "allows a Traduction to be updated" do
        prev_updated_at = @traduction.updated_at
        expect {put 'update', :id => @traduction.id, :key => "hello", :value => {"en" => "new hello"}}.to change(Translation, :count).by(0)       
        @traduction.reload
        @traduction.updated_at.should > prev_updated_at
      end
    end

    context "updating a trad with a new locale" do
      it "should create a new Traduction and not update the existing one" do
        prev_updated_at = @traduction.updated_at
        expect {put 'update', :id => @traduction.id, :key => "hello", :value => {"fr" => "nouveau hello"}}.to change(Translation, :count).by(1)       
        @traduction.reload
        @traduction.updated_at.should == prev_updated_at
      end
    end

    context "updating a trad with removing a value for a locale" do
      it "should destroy the locale record and not update the existing one" do
        FactoryGirl.create(:translation_es)
        prev_updated_at = @traduction.updated_at
        expect {put 'update', :id => @traduction.id, :key => "hello", :value => {"es" => ""}}.to change(Translation, :count).by(-1)       
        @traduction.reload
        @traduction.updated_at.should == prev_updated_at
        response.should redirect_to "/traductions"
      end
    end
  end

end
