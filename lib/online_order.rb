require_relative "order.rb"
require_relative "customer.rb"

module Grocery
  class OnlineOrder < Order
    attr_reader :id, :products, :customer, :status
     def initialize(id, products, customer_id, status=:pending)
       super(id, products)
       @customer = Customer.find(customer_id)
       @status = status.to_sym
     end

     def total
       total = super
       if total != 0.00
         total += 10.00
       end
       return total
     end

     def add_product(product_name, product_price)
       case @status
       when :processing, :shipped, :complete
         raise ArgumentError.new("You cannot add another product because your order is #{@status}.")
       when :pending, :paid
         super
       end
     end

     def self.all
       orders_array = []
       CSV.open("support/online_orders.csv", "r").each do |order|
         id = order[0].to_i
         customer_id = order[2].to_i
         status = order[3]

         products_hash = {}
         products_array = order[1].split(";")
         products_array.each do |product|
           product_info = product.split(":")
           products_hash[product_info[0]] = product_info[1].to_f
         end

         orders_array << OnlineOrder.new(id, products_hash, customer_id, status)
       end
       return orders_array
     end

     # OnlineOrder.find method inherits from Order.find, which uses self.all
     # because OnlineOrder also has a self.all method, the .find method refers to OnlineOrder.all
     # and not Order.all
     # the functionality of .all needs not be replicated here 
     def self.find(online_order_id)
       order_found = super
       if order_found.nil?
         raise ArgumentError.new("Order number #{online_order_id} does not exist.")
       end
       return order_found
     end

     def self.find_by_customer(customer_id)
       customer = Customer.find(customer_id)
       if customer.nil?
         raise ArgumentError.new("Customer #{customer_id} does not exist in our records.")
       else
         all_orders = self.all
         customer_orders = []
         all_orders.each do |order|
           if order.customer.id == customer.id
             customer_orders << order
           end
         end
       end

       return customer_orders

     end


  end # OnlineOrder class
end # Grocery module
