class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates :user, :product, :description, :rating, presence: true
end
