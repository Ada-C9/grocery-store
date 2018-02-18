# Beginning WAVE 2 now.

require 'csv'
require 'awesome_print'



module Grocery

  class Order
    attr_reader :id
    attr_accessor :products

    @@raw = nil
    @@array_of_processed_orders = []
    @@all_order_instances = []

    def initialize(id, products)
      @id = id
      @products = products
    end

    def self.raw
      return @@raw
    end

    def self.array_of_processed_orders
      return @@array_of_procesed_orders
    end

    def self.all_order_instances
      return @@all_order_instances
    end

    def self.process_order_csv(raw_order_array)
      processed_order = []
      processed_order[0] = raw_order_array[0]
      separated_products = raw_order_array[1].split(";")
      product_price_array = []
      separated_products.each do |product_with_price|
        product_price_pair = product_with_price.split(":")
        product_price_array << product_price_pair
      end
      processed_order[1] = product_price_array.to_h
      return processed_order
    end

    def self.all
      @@raw = CSV.parse(File.read('../support/orders.csv'))
      @@raw.each do |initial_order_data|
        processed_entry = process_order_csv(initial_order_data)
        @@array_of_processed_orders << processed_entry
      end
      @@array_of_processed_orders.each do |individual_order_array|
        temporary_order = Order.new(individual_order_array[0], individual_order_array[1])
        @@all_order_instances << temporary_order
      end
      return @@all_order_instances
    end

  end
end

##MISC STUFF FOR TESTING
#first_order = Grocery::Order.new(first_test[0], first_test[1])
##puts first_order.add_product("seagull", 12.50).inspect
#puts first_order.products.inspect
#puts first_order.id.inspect
#ap first_order

# ap Grocery::Order.all

puts Grocery::Order.all[0].inspect

puts Grocery::Order.all[99].inspect

# ap Grocery::Order.all
#
# ap Grocery::Order.all

puts Grocery::Order.all.length
