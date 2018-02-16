
module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = 0
      if !(@products.empty?) || @products !=  nil
        @products.each do |product, cost|
          sum += cost
        end
        sales_tax = 0.075
        sum = (sum + (sum * sales_tax)).round(2)
      end
      return sum
      # TODO: implement total
    end

    def add_product(product_name, product_price)
      @products[product_name] = product_price
      # TODO: implement add_product
    end

    def remove_product(product_name)
      @products.delete(product_name)
    end
  end
end
