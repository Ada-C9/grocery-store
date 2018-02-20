require 'csv'
require 'awesome_print'
require_relative '../lib/order'

module Grocery
  class OnlineOrder < Grocery::Order
    attr_reader :id, :customer_id, :status
    attr_accessor :products

    def initialize(id, products, customer_id, status)
      super(id, products)
      @customer_id = customer_id
      @status = status
    end

    def total
    end

    def add_product
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
      processed_order[2] = raw_order_array[2]
      processed_order[3] = raw_order_array[3]
      return processed_order
    end

    def self.all
      raw_csv_file = CSV.parse(File.read('../support/online_orders.csv'))
      array_of_processed_orders = []
      raw_csv_file.each do |initial_order_data|
        processed_entry = process_order_csv(initial_order_data)
        array_of_processed_orders << processed_entry
      end
      all_order_instances = []
      array_of_processed_orders.each do |individual_order_array|
        temporary_order = OnlineOrder.new(individual_order_array[0], individual_order_array[1], individual_order_array[2], individual_order_array[3])
        all_order_instances << temporary_order
      end
      return all_order_instances
    end

    def self.find(id)
    end

    def self.find_by_customer(customer_id)
    end
  end
end

#MISC TESTING STUFF
# ap Grocery::OnlineOrder.all
# puts Grocery::OnlineOrder.all[0].inspect
# puts Grocery::OnlineOrder.all[99].inspect
# puts Grocery::OnlineOrder.all.length
