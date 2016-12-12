require 'rails_helper'
require 'money-rails/test_helpers'

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

    it 'should be valid when all fields are present' do
      expect(product).to be_valid
      expect(product).to monetize(:price)
    end

    it 'should be valid when quantity and price are zero' do
      product.quantity = 0
      product.price = 0
      expect(product).to be_valid
    end

    it 'should be invalid when name not present' do
      product.name = nil
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
      product.name = ''
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should be invalid when quantity not present' do
      product.quantity = nil
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should be invalid when category not present' do
      product.category = nil
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end

    it 'should be invalid when price not present' do
      product_without_price = category.products.new({
          name: 'product name',
          description: 'product description',
          quantity: 10
        })
      expect(product_without_price).to_not be_valid
      expect(product_without_price).to monetize(:price)
      expect(product_without_price.errors.full_messages).to include("Price is not a number")
    end

    it 'should be invalid if price is not a number' do
      product_with_invalid_price = category.products.new({
          name: 'product name',
          description: 'product description',
          quantity: 10,
          price: 'chicken train'
        })
      expect(product_with_invalid_price).to_not be_valid
      expect(product_with_invalid_price).to monetize(:price)
      expect(product_with_invalid_price.errors.full_messages).to include("Price is not a number")
    end

  end

end
