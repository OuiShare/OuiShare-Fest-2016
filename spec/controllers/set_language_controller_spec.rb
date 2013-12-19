require 'spec_helper'

describe SetLanguageController do

  before(:each) do
    http_login    
  end

  describe "GET 'new language'" do
    it "returns http success" do
      get 'set_new_language', :language_code => "fr"
      response.status.should eq 302
    end
  end

end
