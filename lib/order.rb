require 'csv'
require 'awesome_print'

FILE_NAME = 'support/orders.csv'

module Grocery

  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end


    def total
      product_total = 0
      sub_total = 0
      @products.each_value do |prices|
        sub_total += prices
      end
      return product_total = (sub_total * 0.075).round(2) + sub_total.round(2)
    end


    def add_product(product_name, product_price)
      return false if @products.has_key?(product_name)
      @products[product_name] = product_price
      return true
    end

    def self.all
      order_product = []
      result = {}
      all_order = []
      CSV.open(FILE_NAME, 'r').each do |product|
        order_product << "#{product[1]}"
        id = product[0].to_i
        order_product.each do |product_string|
          result = Hash[
            product_string.split(';').map do |pair|
              product, price = pair.split(':', 2)
              [product, price.to_i]
            end
          ]
        end
        all_order << Grocery::Order.new(id, result)
      end
      return all_order
    end


    def self.find(find_id)
      find_product = self.all
      return_value = nil
      find_product.each do |order|
        if find_id == order.id
          return_value = order
        end
      end
      return return_value
    end

end # class Order

end # module Grocery
