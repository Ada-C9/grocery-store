require 'awesome_print'
require 'csv'
require File.expand_path('../order.rb', __FILE__)

# Do I need to create a grocery class?
class OnlineOrder < Grocery::Order
  attr_accessor :customer_id, :fulfillment_status, :total, :order_id, :status, :products

  @@organized_online_orders = []

  def initialize (order_id, customer_id, order_status, products)
    status_array = [:pending, :paid, :processing, :shipped, :complete]
    @customer_id = customer_id.to_i
    @order_id = order_id.to_i
    @status = order_status.to_sym
    if !status_array.include?(order_status)
      @status = :pending
    end
    @products = products
  end

  def total
    @total = super total + 10
    return @total
  end

  def add_product (product_name, product_price, add_id)
    if @status == "pending" || @status == "paid"
      super add_product(product_name, product_price, add_id)
    else
      raise ArgumentError.new "Argument Error: product status."
    end
  end

  def self.all
    @@organized_online_orders.clear
    array_of_orders_data = CSV.read("support/online_orders.csv")
    array_of_orders_data.each do |order|
      products = Hash.new
      id = order[0].to_i
      customer_id = order[2]
      status = order[3]
      product_prices = order[1].split(";")
      product_prices.each do |product_price|
        product_price = product_price.split(":")
        products.store(product_price[0], product_price[1].to_f)
      end
      @@organized_online_orders << OnlineOrder.new(id, customer_id, status, products)
    end
    return @@organized_online_orders
  end

  def self.find (order_id)
    found_order = false
    @@organized_online_orders.each do |order|
      if order.order_id == order_id
        found_order = order.products
      end
    end
    return found_order
  end

  def self.find_by_customer (customer_id_entry)
    found_order = false
    @@organized_online_orders.each do |order|
      if order.customer_id == customer_id_entry
        found_order = order.products
      end
    end
    return found_order
  end
end
OnlineOrder.all
