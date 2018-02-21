require "csv"

module Grocery
  class Order
    attr_reader :id, :products#,  :add_product, :total, :result#, :product_name, :product_price

#Takes an ID and collection of products
    def initialize(id, products)
      if id == id.to_i
        @id = id
      else
        id = rand(1111..9999)
        @id = id
      end
      @products = products
    end

    #Returns the total price from the collection of products
    def total
      # TODO: implement total
      if products.length == 0
         return 0
      end
     ((@products.values.sum)*1.075).round(2)
    end

# Increases the number of products
    def add_product(product_name, product_price)
      # TODO: implement add_product
      # @product_name = product_name
      # @product_price = product_price
      if @products.include?(product_name) == false
        @products[product_name] = product_price
        result = true
      else
        result = false
      end
      @result = result
    end

    # Returns an array of all orders
    def self.all
      # TODO: implement all.
      # formats CSV file to work with class
          arr_orders = Array.new
          CSV.read('support/orders.csv', 'r').each do |line|
            arr_orders << line
          end

          arr_orders.each do |line|
            id = line[0].to_i
            line[0] = id
            @id = id
            product = line[1].split(";")
            line[1] = product
            array_split = Array.new
            line[1].each do |element|
              array_split << element.split(":")
            end
            array_split.each do |item|
              item[1] = item[1].to_f
            end
            line[1] = array_split.to_h
          end
        return arr_orders
    end

    # Can find the order from the dataset
    def self.find(id_lookup)
      # TODO: implement all.
      Grocery::Order.all[(id_lookup-1)]
    end

  end
end
