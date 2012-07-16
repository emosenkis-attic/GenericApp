require 'spec_helper'

describe "listings/index" do
  before(:each) do
    assign(:listings, [
      stub_model(Listing,
        :user_id => "",
        :title => "Title",
        :descr => "MyText",
        :approved => "",
        :url => "Url"
      ),
      stub_model(Listing,
        :user_id => "",
        :title => "Title",
        :descr => "MyText",
        :approved => "",
        :url => "Url"
      )
    ])
  end

  it "renders a list of listings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
