require 'csv'
require 'awesome_print'
require_relative 'order.rb'
require_relative 'customer.rb'

class OnlineOrder < Grocery::Order
  attr_reader :id, :products, :customer, :fulfillment_status
  def initialize(id, products, customer, fulfillment_status = 'pending')
    @id = id
    # super (products)
    @products = products
    # super(products)

    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def add_product(product_name, product_price)
    if @fulfillment_status == "pending" || @fulfillment_status == "paid"
      return super
    else
      raise ArgumentError.new("ERROR: status is not pending or paid")
    end
  end

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
      customer = Grocery::Customer.find(customer_id)
      status = row[3]
      new_online_order = OnlineOrder.new(id, products, customer, status)
      all_online_orders << new_online_order
    end
    return all_online_orders
  end

  def self.find(online_order_id)
    online_orders = OnlineOrder.all
    online_orders.each do |online_order|
      if online_order.id == online_order_id
        return online_order
      end
    end
    return nil
  end

  # def self.find_by_customer(customer_id)
  #   customer_orders = []
  #   i = 0
  #   while i < 100
  #     if OnlineOrder(customer_id) != nil
  #       customer_orders << OnlineOrder(customer_id)
  #     end
  #   end
  #
  # end

end

# online_orders = OnlineOrder.all
# one_order = OnlineOrder.find(3)
# ap one_order

# ap online_orders
#
# test_id = 123
# test_email = "test@email.com"
# test_address = "test address"
# customer = Grocery::Customer.new(test_id, test_email, test_address)
# # ap customer
# test_case = OnlineOrder.new(123, {"apple"=>1.00}, customer, "processing")
# # ap test_case
# ap test_case.add_product("banana", 1.25)

# list = []
# CSV.open("../support/online_orders.csv", 'r').each do |row|
#   list << row
# end
#
# list.first(2).each do |row|
#   id = row[0].to_i
#   groceries = []
#   products = row[1].split(";")
#   products.each do |item|
#      groceries << item.split(":")
#      products = groceries.to_h
#      products.each {|key,val| products[key] = val.to_f}
#   end
#   customer_id = row[2].to_i
#   status = row[3]
#   # ap id
#   # ap products
#   # ap customer_id
#   # ap status
# end
