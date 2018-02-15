module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      subtotal = 0
      @products.each do |product, price|
        subtotal += price
      end
      total = subtotal + (subtotal * 0.075)
      return total.round(2)
    end

    def add_product(product_name, product_price)
      # id = rand(0001..9999)
      # until @products.include?(id) != true
      #   id = rand(0001..9999)
      # end
      products = {product_name => product_price}
      products.each do |product, price|
        if @products.include? product
          return false
        else
          @products.merge!({product => price})
          return true
        end
      end
    #return  @products.merge!({product_name: product_price})
    end
  end
end
