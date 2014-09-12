require 'spec_helper'

describe "magazines/new" do
  before(:each) do
    assign(:magazine, stub_model(Magazine).as_new_record)
  end

  it "renders new magazine form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", magazines_path, "post" do
    end
  end
end
