require 'rails_helper'

RSpec.describe "authors/new", :type => :view do
  before(:each) do
    assign(:author, Author.new(
      :username => "MyString",
      :email => "MyString",
      :password => "",
      :password_confirmation => ""
    ))
  end

  it "renders new author form" do
    render

    assert_select "form[action=?][method=?]", authors_path, "post" do

      assert_select "input#author_username[name=?]", "author[username]"

      assert_select "input#author_email[name=?]", "author[email]"

      assert_select "input#author_password[name=?]", "author[password]"

      assert_select "input#author_password_confirmation[name=?]", "author[password_confirmation]"
    end
  end
end
