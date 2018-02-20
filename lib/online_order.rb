require 'csv'
require_relative 'order'
require_relative 'customer'

ONLINE_FILE = 'support/online_orders.csv'

module Grocery
  class OnlineOrder < Order
    attr_reader :status, :customer

    def initialize(id, products, customer_id, status=:pending)
      super(id, products)
      @customer = Customer.find(customer_id)
      @status = status
    end

    # if the online order instance has no products, returns the total provided by Order#total (no shipping)
    # otherwise, returns total provided by Order#total + $10 for shipping
    def total
      super
      if @products.empty?
        return super
      else
        return super + 10
      end
    end

    # returns false if the product name is already included in the online order's products,
    # raises an ArgumentError if the online order status is processing, shipped or complete,
    # otherwise adds product to the instance's product hash and returns true
    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      elsif [:processing, :shipped, :complete].include?(@status)
        raise ArgumentError.new("The order status is #{@status}. New products can no longer be added to this order.")
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    # reads csv file (set to online_orders.csv by default if no other file is given)
    # iterates through each line (array) of the csv file to parse the id, product, customer id, and status data
    # for each line, creates a new instance of the OnlineOrder class and adds it to an array of all OnlineOrder instances
    def self.all(csv_file=ONLINE_FILE)
      csv_array = CSV.read(csv_file, 'r')
      all_online_orders = []
      csv_array.each do |online_order|
        id = online_order[0].to_i
        products = Hash[online_order[1].split(/:|;/).each_slice(2).collect { |k, v| [k,v.to_f] }]
        customer_id = online_order[2].to_i
        status = online_order[3].to_sym
        new_online_order = OnlineOrder.new(id, products, customer_id, status)
        all_online_orders << new_online_order
      end
      return all_online_orders
    end

    # iterates through the array returned by the self.all method to find an online order with an id equal to the provided argument
    # raises an ArgumentError if the provided id does not match an id in the array returned by self.all
    def self.find(id, csv_file=ONLINE_FILE)
      OnlineOrder.all(csv_file).each do |online_order|
        if online_order.id == id
          return online_order
        end
      end
      raise ArgumentError.new("Order #{id} could not be found in the online order database.")
    end

    # looks for the customer id (provided as an argument) in the customer database (which will raise an ArgumentError if id is not found)
    # iterates through array returned by the self.all method to find online orders with a customer id equal to the provided argument
    # adds identified OnlineOrder instances to an array of online orders for the given customer
    def self.find_by_customer(num, csv_file=ONLINE_FILE)
      Customer.find(num)
      online_orders =[]
      OnlineOrder.all(csv_file).each do |online_order|
        if online_order.customer.id == num
          online_orders << online_order
        end
      end
      return online_orders
    end
  end
end
