require 'spec_helper'

describe "magazines/index" do
  before(:each) do
    assign(:magazines, [
      stub_model(Magazine),
      stub_model(Magazine)
    ])
  end

  it "renders a list of magazines" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
