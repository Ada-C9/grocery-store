module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = @products.values.sum
      expected_total = sum + (sum * 0.075).round(2)
      return expected_total
    end


    def add_product(product_name, product_price)

      return false if @products.has_key?(product_name)
      @products[product_name] = product_price
      p @products
      # else
      return true
    end

    # Add a `remove_product` method to the `Order` class which will take in one parameter, a product name, and remove the product from the collection
    #     - It should return `true` if the item was successfully remove and `false` if it was not
    def remove_product(product_name)
      p @products
      if @products.key?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
      # return true if @products.key?(product_name)
      # @products.delete(product_name)
      #
      # return false
    end
  end
end
