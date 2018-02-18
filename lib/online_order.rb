require 'csv'
require 'awesome_print'
require_relative 'order.rb'
require_relative 'customer.rb'

ONLINE_FILE_NAME = 'support/online_order.csv'


module  Grocery

  class OnlineOrder < Order
    attr_reader :customer_id, :status

    def initialize(id, products, customer_id, status)
      super(id, products)
      # @id = id
      # @products = products
      @customer_object = customer_id
      @status = status.to_sym
    end


    def total
      if @products.length > 0
        return (super()+10).round(2)
      else
        return 0
      end
    end

    def add_product(name, price)
      if [:pending, :paid].include?(@status)
        super(name,price)
      end
    end

  end
end

new_online_order = Grocery::OnlineOrder.new(434, {"product": 5.50, "apples": 4.50},45,"pending")

puts new_online_order.total

puts new_online_order.products

puts Grocery::Customer.find(new_online_order.customer_id)
