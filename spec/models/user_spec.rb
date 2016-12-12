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

  end
end
