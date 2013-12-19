require 'spec_helper'

include Devise::TestHelpers

describe AdminController do 
   
  render_views

  before(:each) do
    http_login   
    request.session[:allowed_admin] = false          
  end

  describe "Get 'index'" do
    context "Not logged as admin" do
      login_user
      it "should redirect user to root" do
        get 'index'
        response.should redirect_to root_path
        flash[:alert].should eq 'You don\'t have the rights to come here.'
      end
    end
    context "Logged as admin" do
      login_admin
      context "Without Strong Auth" do
        it "should be able to access admin interface" do
          get 'index'
          response.should be_success
        end
      end
      
      # context "With Strong Auth without session false" do       
                      
      #   it "should not be able to access admin interface without session variable set" do          
      #     get 'index'          
      #     response.should_not be_success          
      #   end 
      # end

      context "With Strong Auth without session true" do       
           
        it "should be able to access admin interface with session variable set" do
          get 'index'
          response.should be_success
       end
      end
    end    
  end 
end
