require 'rails_helper'

RSpec.describe "authors/edit", :type => :view do
  before(:each) do
    @author = assign(:author, Author.create!(
      :username => "MyString",
      :email => "MyString",
      :password => "",
      :password_confirmation => ""
    ))
  end

  it "renders the edit author form" do
    render

    assert_select "form[action=?][method=?]", author_path(@author), "post" do

      assert_select "input#author_username[name=?]", "author[username]"

      assert_select "input#author_email[name=?]", "author[email]"

      assert_select "input#author_password[name=?]", "author[password]"

      assert_select "input#author_password_confirmation[name=?]", "author[password_confirmation]"
    end
  end
end
