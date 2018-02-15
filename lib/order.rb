module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
      @tax = 0.075
      @total = 0.00
    end

    def total
      # TODO: implement total
      sub_total = 0.00
      @products.each do |product, cost|
        sub_total += cost
      end
      # return sub_total

      @total = sub_total + (sub_total * @tax).round(2)
      return @total
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      if @products.key?(product_name) #method to see if the product already exists in product hash
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end
  end
end
