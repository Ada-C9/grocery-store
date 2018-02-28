require 'csv'
require 'awesome_print'
require_relative 'order.rb'
require_relative 'customer.rb'

class OnlineOrder < Grocery::Order

  # id and products do not have to be attr_reader bc they are attr_readers in the Order class
  attr_reader :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    super id, products
    # @id = id
    # @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  # Adds a product only if fulfillment_status equals pending or paid
  def add_product(product_name, product_price)
    if @fulfillment_status == :pending || @fulfillment_status == :paid
      return super
    else
      raise ArgumentError.new("ERROR: status is not pending or paid")
    end
  end

  # If the total from Order.total = 0, do not add the shipping fee
  def total
    if super == 0
      return 0
    end
    return super + 10.00
  end

  def self.all
    list = []
    CSV.open("support/online_orders.csv", 'r').each do |row|
      list << row
    end

    all_online_orders = []
    # Parses out online_order_id, products, customer_id, and fulfillment_status
    list.each do |row|
      id = row[0].to_i
      groceries = []
      products = row[1].split(";")
      products.each do |item|
         groceries << item.split(":")
         products = groceries.to_h
         products.each {|key,val| products[key] = val.to_f}
      end
      customer_id = row[2].to_i
      # Uses Customer.find class method to return one instance of a Customer
      customer = Grocery::Customer.find(customer_id)
      status = row[3].to_sym
      # Creates one instnace of Online Order and adds it to an Array of OnlineOrders
      new_online_order = self.new(id, products, customer, status)
      all_online_orders << new_online_order
    end
    return all_online_orders
  end

  # Finds one online order out of array of online orders. Returns nil if the OnlineOrder does not exist
  # def self.find(online_order_id)
  #   online_orders = self.all
  #   online_orders.each do |online_order|
  #     if online_order.id == online_order_id
  #       return online_order
  #     end
  #   end
  #   return nil
  # end

  def self.find_by_customer(customer_id)
    num_of_customers = 35
    # Check if customer_id exists based on knowledge on how many customers exist
    if customer_id > num_of_customers || customer_id < 0
      return nil
    end

    customer_orders = []
    online_orders = self.all
    # Iterates through array of OnlineOrders to find all orders that have customer_id. Adds these OnlineOrders to customer_orders

    return online_orders.find_all {|order| order.customer.id == customer_id}

  end

end
