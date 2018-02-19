

require 'csv'
require 'awesome_print'



module Grocery

  class Order
    attr_reader :id
    attr_accessor :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def self.process_order_csv(raw_order_array)
      processed_order = []
      processed_order[0] = raw_order_array[0]
      separated_products = raw_order_array[1].split(";")
      product_price_array = []
      separated_products.each do |product_with_price|
        product_price_pair = product_with_price.split(":")
        product_price_pair[1] = product_price_pair[1].to_f #not sure if I need this, but it was driving me nuts
        product_price_array << product_price_pair
      end
      processed_order[1] = product_price_array.to_h
      return processed_order
    end

    def self.all
      raw_csv_file = CSV.parse(File.read('../support/orders.csv'))
      array_of_processed_orders = []
      raw_csv_file.each do |initial_order_data|
        processed_entry = process_order_csv(initial_order_data)
        array_of_processed_orders << processed_entry
      end
      all_order_instances = []
      array_of_processed_orders.each do |individual_order_array|
        temporary_order = Order.new(individual_order_array[0], individual_order_array[1])
        all_order_instances << temporary_order
      end
      return all_order_instances
    end
    def self.find(query_id)
      found_order = Grocery::Order.all.find {|order_instance| order_instance.id == query_id}
      return found_order
    end

    def add_product(product, price)
      before_count = @products.count
        if !@products.include?(product)
          @products = @products.merge(product => price)
        end
      before_count + 1 == @products.count
    end
    def remove_product(product)
      before_count = @products.count
      @products.delete(product)
      before_count - 1 == @products.count
    end
    def total
      sum = @products.values.inject(0, :+)
      sum_with_tax = expected_total = sum + (sum * 0.075).round(2)
      return sum_with_tax
    end
  end
end

##MISC STUFF FOR TESTING WAVE 1
#first_order = Grocery::Order.new(first_test[0], first_test[1])
##puts first_order.add_product("seagull", 12.50).inspect
#puts first_order.products.inspect
#puts first_order.id.inspect
#ap first_order

#MISC STUFF FOR TESTING WAVE 2
# ap Grocery::Order.all
# puts Grocery::Order.all[0].inspect
# puts Grocery::Order.all[99].inspect
# puts Grocery::Order.all.length
