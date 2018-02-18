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


  end # OnlineOrder class
end # Grocery module

# online_order = Grocery::OnlineOrder.new(9,{"Iceberg lettuce"=>88.51,"Rice paper"=>66.35, "Amaranth"=>1.5, "Walnut"=>65.26},14,"paid"
# )
#
# puts online_order.status
