require 'rails_helper'

RSpec.describe User, type: :model do

    let(:user) do
      User.create!(
        first_name: "first_name",
        last_name: "last_name",
        email: "user@email.com",
        password: "password",
        password_confirmation: "password"
      )
    end

  describe "Validations" do

    it "is valid when all data is present" do
      expect(user).to be_valid
    end

    it "is invalid if password is missing" do
      user.password = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
      user.password = ''
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
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
end
