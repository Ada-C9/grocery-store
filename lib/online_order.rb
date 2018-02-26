# require "order.rb"
require_relative "order.rb"
require "awesome_print"
require_relative 'customer'

module Grocery

  # class OnlineOrder < Grocery::Order
  class OnlineOrder < Order

    @@all_online_orders = []

    # attr_reader :id, :products, :customer_id, :status
    attr_reader :customer_id, :status


    def initialize(id, products, customer_id, status)
      super(id, products)
      @customer_id = customer_id
      # @customer = customer.find(customer_id)
      @status = status
    end

    def total
      if super == 0
        return 0
      else
        return super + 10
      end
    end

    def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        super
      else
        raise ArgumentError.new("Order must be pending or paid in order to add products.")
      end
    end

    def self.all
      @@all_online_orders = []
      #
      # @customer_id = ""
      # CSV.read('../support/online_orders.csv', 'r').each do |row|
      CSV.read('support/online_orders.csv', 'r').each do |row|
        row.each do
          @id = row[0].to_i
          split_products = row[1].split(";")
          keys_values = split_products.map {|item| item.split /\s*:\s*/ }
          @products = Hash[keys_values]
          @customer_id = row[2].to_i
          @status = row[3].to_sym
        end
        @@all_online_orders << OnlineOrder.new(@id, @products, @customer_id, @status)
      end
      return @@all_online_orders
    end

    # def self.find(id)
    #   # returns an instance of OnlineOrder where the value of the id field in the CSV matches the passed parameter.
    #   @@all_online_orders = Grocery::OnlineOrder.all
    #   order_instance = @@all_online_orders.find_all { |order| order.id == id }
    #   if order_instance.length <= 0
    #     return nil
    #   else
    #     return order_instance
    #   end
    # end

    def self.find_by_customer(customer_id)
      # returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.
      # open array to store all customer ids (customers wont exists on oneline orders csv if they did not order anything)
      # call customer.all and do .each do and grab id from each customer object and store them in customer ids arrays.
      @@all_online_orders = Grocery::OnlineOrder.all
      order_instances = @@all_online_orders.find_all { |order| order.customer_id == customer_id }
      if order_instances.length <= 0
        return order_instances
      else
        return order_instances
      end
    end
  end
end

  # new_order = OnlineOrder.new("4", "Aubergine:56.71;Brown rice vinegar:33.52;dried Chinese Broccoli:51.74", "35", "shipped")
  # ap new_order
  # ap new_order.total
  # ap OnlineOrder.all
  # ap new_order.add_product("bananas", 1.99)
  # ap Grocery::OnlineOrder.find(7)
  # ap Grocery::OnlineOrder.find_by_customer(25)
