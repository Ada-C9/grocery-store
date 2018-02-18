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


  end # OnlineOrder class
end # Grocery module

# online_order = Grocery::OnlineOrder.new(9,{"Iceberg lettuce"=>88.51,"Rice paper"=>66.35, "Amaranth"=>1.5, "Walnut"=>65.26},14,"paid"
# )
#
# puts online_order.status
