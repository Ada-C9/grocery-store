module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      ((@products.values.sum) * 1.075).round(2)
    end

    def add_product(product_name, product_price)
      if @products.keys.include? (product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      if @products.keys.include? (product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end
  end
end


# describe 'remove_product' do
#
#   it "returns true if the product is removed" do
#     products = { "banana" => 1.99, "cracker" => 3.00, "salad" => 4.25}
#     order = Grocery::Order.new(1337, products)
#
#     result = order.remove_product("salad")
#     result.must_equal true
#     products.length.must_equal 2
#   end
# end
