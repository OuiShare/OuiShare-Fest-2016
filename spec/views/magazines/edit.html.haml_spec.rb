require 'spec_helper'

describe "magazines/edit" do
  before(:each) do
    @magazine = assign(:magazine, stub_model(Magazine))
  end

  it "renders the edit magazine form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", magazine_path(@magazine), "post" do
    end
  end
end
