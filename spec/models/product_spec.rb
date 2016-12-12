require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:category) {Category.create(name: 'Stuff')}
  let(:product) do
    category.products.new({
      name: 'product name',
      description: 'product description',
      quantity: 10,
      price: 99.99
    })
  end

  describe 'Validations' do
    it 'should be valid with all fields present' do
      expect(product).to be_valid
    end
  end

end
