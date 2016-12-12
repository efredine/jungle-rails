require 'rails_helper'

RSpec.describe User, type: :model do


  describe "Validations" do

    let(:user) do
      User.new(
        first_name: "first_name",
        last_name: "last_name",
        email: "user@email.com",
        password: "password",
        password_confirmation: "password"
      )
    end

    it "is valid when all data is present" do
      expect(user).to be_valid
    end

    it "is invalid if password is blank" do
      user.password = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
      user.password = ''
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it "is invalid if email is blank" do
      user.email = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
      user.email = ''
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it "is invalid if email is not unique" do
      existingUser = User.create!(
        first_name: "first_name_2",
        last_name: "last_name_2",
        email: "user@email.com",
        password: "password",
        password_confirmation: "password"
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email has already been taken")
      user.email = "USER@email.com"
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it "is invalid if first name is blank" do
      user.first_name = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
      user.first_name = ''
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it "is invalid if last name is blank" do
      user.last_name = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Last name can't be blank")
      user.last_name = ''
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it "is invalid if password is too short" do
      user.password = "short"
      user.password_confirmation = "short"
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end

    it "is invalid if password_confirmation doesn't match" do
      user.password_confirmation = 'something else'
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end

  describe ".authenticate_with_credentials" do

    let!(:user) do
      User.create!(
        first_name: "first_name",
        last_name: "last_name",
        email: "user@email.com",
        password: "password",
        password_confirmation: "password"
      )
    end

    it "should authenticate with correct email and password" do
      authenticated_user = User.authenticate_with_credentials("user@email.com", "password")
      expect(authenticated_user).to eq(user)
    end

    it "should not authenticate with invalid email" do
      authenticated_user = User.authenticate_with_credentials("other@email.com", "password")
      expect(authenticated_user).to be_nil
    end

    it "should not authenticate with matching email but incorrect password" do
      authenticated_user = User.authenticate_with_credentials("user@email.com", "wrong")
      expect(authenticated_user).to be_nil
    end

    it "should match user provided email with different case" do
      authenticated_user = User.authenticate_with_credentials("USER@email.com", "password")
      expect(authenticated_user).to eq(user)
    end

    it "should match if original email provided by user has different case" do
      user2 = User.create!(
        first_name: "first_name",
        last_name: "last_name",
        email: "USER2@email.com",
        password: "password",
        password_confirmation: "password"
      )
      authenticated_user = User.authenticate_with_credentials("user2@email.com", "password")
      expect(authenticated_user).to eq(user2)
    end

    it "should match if user provided email has extra spaces before or after the email" do
      authenticated_user = User.authenticate_with_credentials("   user@email.com   ", "password")
      expect(authenticated_user).to eq(user)
    end

     it "should match if original email provided by user has space before or after email" do
      user2 = User.create!(
        first_name: "first_name",
        last_name: "last_name",
        email: "         user2@email.com  ",
        password: "password",
        password_confirmation: "password"
      )
      authenticated_user = User.authenticate_with_credentials("user2@email.com", "password")
      expect(authenticated_user).to eq(user2)
    end

  end

end
