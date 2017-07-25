require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
    password: "foobar", passwork_confirmation: "foobar")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  # verify that it at least have a name
  
  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end
  
  test "emial should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
 test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email should be a valid email address form" do
    valid_addresses = %w[user@example.com USER@foo.com A_US-ER@foo.bar.org
    first.last@foo.jp alice+bob@baz.cn]
    
    valid_addresses.each do |valid_addresses|
      @user.email = valid_addresses
      assert @user.valid?, "#{valid_addresses.inspect} should be valid"
    end
  end
end
