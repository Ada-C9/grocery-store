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
      ((@products.values.sum)*1.075).round(2)
    end

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end

    end

    def to_s
      return "#{@id} #{@products}"

    end

    def self.all
      all_orders = []
      CSV.open(FILE_NAME, 'r').each do |str|
        # puts order
        new_hash = {}
        id = str[0].to_i
        str[1].split(";").each do |pair|
          new_pair = pair.split(":")
          key = new_pair[0]
          value = new_pair[1].to_f
          new_hash[key] = value
        end
        new_order = Order.new(id, new_hash)
        all_orders << new_order
      end
      return all_orders
    end

    def self.find(passed_id)
      return_value = nil
      self.all.each do |order|
        if order.id == passed_id
          return_value = order
        end
      end
      return return_value
    end

  end
end

# ap Grocery::Order.all

# ap Grocery::Order.find(9876)
