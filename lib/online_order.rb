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
      super
      sum_with_tax = super
        if !@products.values.empty?
          sum_with_tax = sum_with_tax + 10
        end
      return sum_with_tax
    end

    def add_product (product, price)
      if @status == "paid"
        super(product, price)
      elsif @status == "pending"
        super(product, price)
      end
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

    def self.find(query_id)
      found_order = Grocery::OnlineOrder.all.find {|order_instance| order_instance.id == query_id}
      if found_order.nil?
        raise ArgumentError.new("That Order ID is not recognized")
      end
      return found_order
    end


    def self.find_by_customer(query_customer_id)
      target_customer_orders = []
      Grocery::OnlineOrder.all.each do |order_instance|
        if order_instance.customer_id == query_customer_id
          order_found = order_instance
          target_customer_orders << order_found
        end
      end
      return target_customer_orders
    end

  end
end

#MISC TROUBLESHOOTING STUFF
# ap Grocery::OnlineOrder.all
# puts Grocery::OnlineOrder.all[0].inspect
# puts Grocery::OnlineOrder.all[99].inspect
# puts Grocery::OnlineOrder.all.length
#
#
# ap Grocery::OnlineOrder.find("1")
# puts Grocery::OnlineOrder.find("1").inspect

# Grocery::OnlineOrder.find("103")
# ap Grocery::OnlineOrder.find("103")
# puts Grocery::OnlineOrder.find("103").inspect

# ap Grocery::OnlineOrder.find("1")
# puts Grocery::OnlineOrder.find("1").inspect

# Grocery::OnlineOrder.find("1")
# puts Grocery::OnlineOrder.find("1").inspect



# online_order_1 = Grocery::OnlineOrder.new("1", {"Lobster" => 17.18,
#   "Annatto seed" => 58.38, "Camomile" => 83.21}, "25", "complete")
#
# puts online_order_1.total.inspect

# online_order_2 = Grocery::OnlineOrder.new("1", {}, "25", "complete")
#
# puts online_order_2.total.inspect


# online_order_paid = Grocery::OnlineOrder.new("39",{"Beans" => 78.89, "Mangosteens" => 35.01}, "31", "paid")
# online_order_paid.add_product("lugnuts", 5.50)
# puts online_order_paid.inspect
# ap online_order_paid
