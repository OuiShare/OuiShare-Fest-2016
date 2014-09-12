require 'spec_helper'

describe "magazines/show" do
  before(:each) do
    @magazine = assign(:magazine, stub_model(Magazine))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
