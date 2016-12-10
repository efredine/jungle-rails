class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates :user, :product, :description, :rating, presence: true
  validates :rating, numericality: {only_integer: true}, inclusion: {in: 1..5, message: "The rating must be between 1 and 5."}
end
