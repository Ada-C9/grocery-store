require 'awesome_print'
require 'csv'
require File.expand_path('../order.rb', __FILE__)

class OnlineOrder < Grocery::Order
  attr_accessor :status
  attr_reader :customer_id

  def initialize(id, customer_id, order_status, products)
    super(id, products)

    status_array = [:pending, :paid, :processing, :shipped, :complete]
    @customer_id = customer_id.to_i
    @status = order_status.to_sym
    if !status_array.include?(order_status)
      @status = :pending
    end
  end

  def total
    if super > 0
      return super + 10
    else
      return 0
    end
  end

  def add_product(product_name, product_price, add_id)
    if @status == :pending || @status == :paid
      super(product_name, product_price)
    else
      return nil
    end
  end

  def self.all
    organized_online_orders =[]
    array_of_orders_data = CSV.read("support/online_orders.csv")
    array_of_orders_data.each do |order|
      products = Hash.new
      product_prices = order[1].split(";")
      product_prices.each do |product_price|
        product_price = product_price.split(":")
        products.store(product_price[0], product_price[1].to_f)
      end
      organized_online_orders << OnlineOrder.new(order[0].to_i, order[2], order[3].to_sym, products)
    end
    return organized_online_orders
  end

  def self.find(order_id)
    if order_id > 0 && order_id < 101
      return self.all[order_id-1].products
    else
      return false
    end
  end

  def self.find_by_customer(customer_id_entry)
    customer_orders = []
    OnlineOrder.all.each do |order|
      if order.customer_id == customer_id_entry
        customer_orders << order
      end
    end
    return customer_orders
  end
end
