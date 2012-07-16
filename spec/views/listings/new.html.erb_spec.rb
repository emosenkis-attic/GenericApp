require 'spec_helper'

describe "listings/new" do
  before(:each) do
    assign(:listing, stub_model(Listing,
      :user_id => "",
      :title => "MyString",
      :descr => "MyText",
      :approved => "",
      :url => "MyString"
    ).as_new_record)
  end

  it "renders new listing form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => listings_path, :method => "post" do
      assert_select "input#listing_user_id", :name => "listing[user_id]"
      assert_select "input#listing_title", :name => "listing[title]"
      assert_select "textarea#listing_descr", :name => "listing[descr]"
      assert_select "input#listing_approved", :name => "listing[approved]"
      assert_select "input#listing_url", :name => "listing[url]"
    end
  end
end
