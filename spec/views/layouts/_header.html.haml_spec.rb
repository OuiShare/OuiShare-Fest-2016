require 'spec_helper'

include Devise

describe "layouts/_header.html.haml" do

  context "When NOT Logged" do
    before do
      view.stub(:user_signed_in?).and_return(false)      
    end
    it "should display the login navbar" do
      render      
      rendered.should have_selector("form", 
      :method => "post", :action => "/login")
    end
  end

  context "When Logged" do    
    before do      
      view.stub(:user_signed_in?).and_return(true) 
      @user = FactoryGirl.create(:user)
      view.stub(:current_user => @user)    
    end
    it "shouldn't display the login navbar" do
      render      
      rendered.should_not have_selector("form", 
      :method => "post", :action => "/login")
    end
  end
end
