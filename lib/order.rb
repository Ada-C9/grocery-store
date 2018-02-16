require 'csv'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end


    def total
      # TODO: implement total
      subtotal = 0
      @products.each do |key, value|
        subtotal += value
      end
      total = subtotal * (1 + 0.075)
      return total.round(2)
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      before_count = @products.length
      if @products.keys.include?(product_name)
        return false
      end
      @products[product_name] = product_price
      if @products.length == before_count + 1
        return true
      else
        return false
      end
    end

    def remove_product(product_name)
      # TODO: implement remove_product
      before_count = @products.length
      if !@products.keys.include?(product_name)
        return false
      else
        @products.delete(product_name)
        return true
      end
    end

    def self.all
      csv_array = ['1,Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9', '2,Albacore Tuna:36.92;Capers:97.99;Sultanas:2.82;Koshihikari rice:7.55', '3,Lentils:7.17']
      orders = []
      csv_array.each do |string|
        # Parse CSV lines
        parsed_csv_arr = string.parse_csv
        result = parsed_csv_arr[1].split(";")
        result = result.map do |x|
          x = x.split(":")
          Hash[x.first, x.last.to_f]
        end
        result = result.reduce(:merge)

        # Create new order and push into orders
        id = parsed_csv_arr[0].to_i
        products = result
        orders << Order.new(id, products)
      end

      return orders
    end

    def self.find(id)

    end

  end
end
